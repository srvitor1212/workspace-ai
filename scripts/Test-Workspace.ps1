[CmdletBinding()]
param(
    [string]$WorkspaceRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($WorkspaceRoot)) {
    $scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
    $WorkspaceRoot = Split-Path -Parent $scriptDirectory
}

$resolvedRoot = (Resolve-Path -LiteralPath $WorkspaceRoot).Path
$failures = New-Object 'System.Collections.Generic.List[string]'

function Add-ValidationFailure {
    param([string]$Message)
    $script:failures.Add($Message)
}

function Get-UnquotedValue {
    param([string]$Value)

    $result = $Value.Trim()
    if ($result.Length -ge 2) {
        $first = $result.Substring(0, 1)
        $last = $result.Substring($result.Length - 1, 1)
        if (($first -eq '"' -and $last -eq '"') -or ($first -eq "'" -and $last -eq "'")) {
            return $result.Substring(1, $result.Length - 2).Trim()
        }
    }

    return $result
}

$requiredFiles = @(
    'AGENTS.md',
    'README.md',
    '.gitignore',
    '.codex/hooks.json',
    '.codex/hooks/chat-memory.ps1',
    '.codex/memory/README.md',
    'templates/project/AGENTS.md',
    'templates/project/README-CODEX.md'
)

foreach ($relativePath in $requiredFiles) {
    $fullPath = Join-Path $resolvedRoot $relativePath
    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        Add-ValidationFailure "Missing required file: $relativePath"
    }
}

$skillsRoot = Join-Path $resolvedRoot '.agents/skills'
$requiredSkills = @(
    'repository-analysis',
    'implementation-plan',
    'implement-change',
    'debugging',
    'code-review',
    'testing',
    'documentation'
)

$discoveredNames = @{}
if (-not (Test-Path -LiteralPath $skillsRoot -PathType Container)) {
    Add-ValidationFailure 'Missing skills directory: .agents/skills'
}
else {
    $skillDirectories = @(Get-ChildItem -LiteralPath $skillsRoot -Directory)

    foreach ($directory in $skillDirectories) {
        $skillFile = Join-Path $directory.FullName 'SKILL.md'
        if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
            Add-ValidationFailure "Skill directory has no SKILL.md: $($directory.Name)"
            continue
        }

        $content = Get-Content -Raw -LiteralPath $skillFile
        $frontmatter = [regex]::Match(
            $content,
            '\A---\r?\n(?<yaml>.*?)\r?\n---(?:\r?\n|\z)',
            [System.Text.RegularExpressions.RegexOptions]::Singleline
        )

        if (-not $frontmatter.Success) {
            Add-ValidationFailure "Invalid or missing YAML frontmatter: .agents/skills/$($directory.Name)/SKILL.md"
            continue
        }

        $yaml = $frontmatter.Groups['yaml'].Value
        $nameMatches = [regex]::Matches($yaml, '(?m)^name:\s*(?<value>.+?)\s*$')
        $descriptionMatches = [regex]::Matches($yaml, '(?m)^description:\s*(?<value>.+?)\s*$')

        if ($nameMatches.Count -ne 1) {
            Add-ValidationFailure "Frontmatter must contain exactly one name: $($directory.Name)"
            continue
        }

        if ($descriptionMatches.Count -ne 1) {
            Add-ValidationFailure "Frontmatter must contain exactly one description: $($directory.Name)"
            continue
        }

        $name = Get-UnquotedValue $nameMatches[0].Groups['value'].Value
        $description = Get-UnquotedValue $descriptionMatches[0].Groups['value'].Value

        if ($name -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$' -or $name.Length -gt 63) {
            Add-ValidationFailure "Invalid skill name '$name' in $($directory.Name)"
        }
        elseif ($name -ne $directory.Name) {
            Add-ValidationFailure "Skill name '$name' does not match directory '$($directory.Name)'"
        }

        if ([string]::IsNullOrWhiteSpace($description)) {
            Add-ValidationFailure "Empty skill description: $($directory.Name)"
        }

        if ($discoveredNames.ContainsKey($name)) {
            Add-ValidationFailure "Duplicate skill name '$name'"
        }
        else {
            $discoveredNames[$name] = $true
        }

        if ($content -match '(?i)<TODO>|\[TODO\]|TBD_PLACEHOLDER') {
            Add-ValidationFailure "Unfinished scaffold placeholder: $($directory.Name)"
        }
    }
}

foreach ($requiredSkill in $requiredSkills) {
    if (-not $discoveredNames.ContainsKey($requiredSkill)) {
        Add-ValidationFailure "Missing required skill: $requiredSkill"
    }
}

$hooksFile = Join-Path $resolvedRoot '.codex/hooks.json'
if (Test-Path -LiteralPath $hooksFile -PathType Leaf) {
    try {
        $hooksConfig = Get-Content -Raw -LiteralPath $hooksFile | ConvertFrom-Json
        if ($null -eq $hooksConfig.hooks.SessionStart) {
            Add-ValidationFailure 'Missing SessionStart chat-memory hook.'
        }
        if ($null -eq $hooksConfig.hooks.PreCompact) {
            Add-ValidationFailure 'Missing PreCompact chat-memory hook.'
        }
    }
    catch {
        Add-ValidationFailure "Invalid .codex/hooks.json: $($_.Exception.Message)"
    }
}

$gitCommand = Get-Command git -ErrorAction SilentlyContinue
if ($null -eq $gitCommand) {
    Add-ValidationFailure 'Git is required to verify that projects/ is ignored.'
}
else {
    & $gitCommand.Source -C $resolvedRoot check-ignore -q -- 'projects/__workspace_validation_probe__'
    if ($LASTEXITCODE -ne 0) {
        Add-ValidationFailure 'The root .gitignore does not ignore projects/.'
    }

    & $gitCommand.Source -C $resolvedRoot check-ignore -q -- '.codex/memory/sessions/__workspace_validation_probe__.md'
    if ($LASTEXITCODE -eq 0) {
        Add-ValidationFailure 'Conversation checkpoints under .codex/memory/sessions/ must not be ignored.'
    }
}

if ($failures.Count -gt 0) {
    foreach ($failure in $failures) {
        Write-Host "[FAIL] $failure" -ForegroundColor Red
    }

    Write-Error "Workspace validation failed with $($failures.Count) error(s)."
    exit 1
}

Write-Host "[OK] Workspace structure is valid. Skills checked: $($discoveredNames.Count)." -ForegroundColor Green
