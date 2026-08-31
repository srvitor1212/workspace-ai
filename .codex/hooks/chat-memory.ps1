[CmdletBinding()]
param(
    [string]$WorkspaceRoot,
    [string]$InputJson
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
[Console]::OutputEncoding = $utf8WithoutBom

function Write-HookResult {
    param([hashtable]$Result)

    [Console]::Out.WriteLine(($Result | ConvertTo-Json -Depth 8 -Compress))
}

function ConvertTo-SafeFileName {
    param([string]$Value)

    $safeValue = [regex]::Replace($Value, '[^A-Za-z0-9._-]', '_')
    if ($safeValue.Length -gt 96) {
        $safeValue = $safeValue.Substring(0, 96)
    }

    if ([string]::IsNullOrWhiteSpace($safeValue)) {
        throw 'The session id cannot be converted to a safe file name.'
    }

    return $safeValue
}

function ConvertTo-YamlSingleQuotedValue {
    param([string]$Value)

    return "'" + $Value.Replace("'", "''") + "'"
}

function Set-HeaderValue {
    param(
        [string]$Content,
        [string]$Name,
        [string]$Value
    )

    $closingMarkers = [regex]::Matches($Content, '(?m)^---\r?$')
    if ($closingMarkers.Count -lt 2) {
        throw 'Memory file has invalid frontmatter.'
    }

    $headerEnd = $closingMarkers[1].Index
    $header = $Content.Substring(0, $headerEnd)
    $pattern = '(?m)^' + [regex]::Escape($Name) + ':.*$'
    if (-not [regex]::IsMatch($header, $pattern)) {
        throw "Memory header has no '$Name'."
    }

    $line = $Name + ': ' + (ConvertTo-YamlSingleQuotedValue $Value)
    $headerRegex = New-Object System.Text.RegularExpressions.Regex($pattern)
    $updatedHeader = $headerRegex.Replace($header, [System.Text.RegularExpressions.MatchEvaluator]{ param($match) $line }, 1)
    return $updatedHeader + $Content.Substring($headerEnd)
}

function ConvertTo-ContextDataValue {
    param(
        [string]$Value,
        [int]$MaxLength
    )

    $normalized = [regex]::Replace($Value, '[\p{C}]', ' ')
    $normalized = [regex]::Replace($normalized, '\s+', ' ').Trim()
    $normalized = [regex]::Replace($normalized, '[^\p{L}\p{N} ._:/\\#@()+-]', '_')
    if ($normalized.Length -gt $MaxLength) {
        $normalized = $normalized.Substring(0, $MaxLength)
    }

    return $normalized
}

function Get-MemoryMetadata {
    param([System.IO.FileInfo]$File)

    $metadata = @{
        path = $File.FullName
        session_id = ''
        work_key = ''
        active_project = ''
        status = ''
        checkpoint_state = ''
        updated_at = ''
    }
    $frontmatterStarted = $false
    $frontmatterClosed = $false

    $headerLines = @(Get-Content -LiteralPath $File.FullName -Encoding UTF8 -TotalCount 32)
    foreach ($line in $headerLines) {
        if ($line -eq '---' -and $frontmatterStarted) {
            $frontmatterClosed = $true
            break
        }

        if ($line -eq '---') {
            $frontmatterStarted = $true
            continue
        }

        if (-not $frontmatterStarted) {
            continue
        }

        if ($line -match '^(session_id|work_key|active_project|status|checkpoint_state|updated_at):\s*(.*)$') {
            $value = $Matches[2].Trim()
            if ($value.Length -ge 2 -and $value.StartsWith("'") -and $value.EndsWith("'")) {
                $value = $value.Substring(1, $value.Length - 2).Replace("''", "'")
            }
            elseif ($value.Length -ge 2 -and $value.StartsWith('"') -and $value.EndsWith('"')) {
                $value = $value.Substring(1, $value.Length - 2)
            }

            $metadata[$Matches[1]] = $value
        }
    }

    if (-not $frontmatterClosed -or $metadata.status -notin @('active', 'completed', 'abandoned')) {
        return $null
    }
    if ($metadata.checkpoint_state -notin @('ready', 'needs-update')) {
        return $null
    }
    if ([string]::IsNullOrWhiteSpace($metadata.session_id) -or (ConvertTo-SafeFileName $metadata.session_id) -ne $File.BaseName) {
        return $null
    }

    $metadata.session_id = $File.BaseName
    $metadata.work_key = ConvertTo-ContextDataValue $metadata.work_key 80
    $metadata.active_project = ConvertTo-ContextDataValue $metadata.active_project 160
    if ([string]::IsNullOrWhiteSpace($metadata.work_key) -or $metadata.work_key -eq 'nao-classificado') {
        return $null
    }
    if ([string]::IsNullOrWhiteSpace($metadata.active_project) -or $metadata.active_project -eq 'nao-informado') {
        return $null
    }

    try {
        $updatedAt = [DateTimeOffset]::Parse(
            $metadata.updated_at,
            [Globalization.CultureInfo]::InvariantCulture,
            [Globalization.DateTimeStyles]::RoundtripKind
        )
        $metadata.updated_at = $updatedAt.ToUniversalTime().ToString('o')
    }
    catch {
        return $null
    }

    return $metadata
}

$eventName = 'unknown'

try {
    if ([string]::IsNullOrWhiteSpace($InputJson)) {
        $InputJson = [Console]::In.ReadToEnd()
    }

    if ([string]::IsNullOrWhiteSpace($InputJson)) {
        throw 'The hook received no JSON input.'
    }

    $hookInput = $InputJson | ConvertFrom-Json
    $sessionId = [string]$hookInput.session_id
    $eventName = [string]$hookInput.hook_event_name
    if ([string]::IsNullOrWhiteSpace($sessionId)) {
        throw 'The hook input has no session_id.'
    }

    if ([string]::IsNullOrWhiteSpace($WorkspaceRoot)) {
        $codexDirectory = Split-Path -Parent $PSScriptRoot
        $WorkspaceRoot = Split-Path -Parent $codexDirectory
    }

    if (-not (Test-Path -LiteralPath $WorkspaceRoot -PathType Container)) {
        throw "Workspace root does not exist: $WorkspaceRoot"
    }

    $resolvedRoot = (Resolve-Path -LiteralPath $WorkspaceRoot).Path
    $memoryRoot = Join-Path $resolvedRoot '.codex/memory/sessions'
    $safeSessionId = ConvertTo-SafeFileName $sessionId
    $memoryFile = Join-Path $memoryRoot ($safeSessionId + '.md')
    $relativeMemoryFile = '.codex/memory/sessions/' + $safeSessionId + '.md'
    $now = [DateTime]::UtcNow.ToString('o')

    if ($eventName -eq 'PreCompact') {
        if (-not (Test-Path -LiteralPath $memoryRoot -PathType Container)) {
            New-Item -ItemType Directory -Path $memoryRoot -Force | Out-Null
        }

        if (Test-Path -LiteralPath $memoryFile -PathType Leaf) {
            $content = [System.IO.File]::ReadAllText($memoryFile)
            $content = Set-HeaderValue $content 'checkpoint_state' 'needs-update'
        }
        else {
            $quotedSessionId = ConvertTo-YamlSingleQuotedValue $sessionId
            $quotedNow = ConvertTo-YamlSingleQuotedValue $now
            $content = @"
---
session_id: $quotedSessionId
work_key: 'nao-classificado'
active_project: 'nao-informado'
status: 'active'
checkpoint_state: 'needs-update'
updated_at: $quotedNow
---

# Checkpoint da conversa

> Pendente: atualize o estado semantico na continuacao.

## Objetivo e estado

## Decisoes e restricoes

## Mudancas e validacoes

## Proximos passos e bloqueios
"@
        }

        [System.IO.File]::WriteAllText($memoryFile, $content, $utf8WithoutBom)
        Write-HookResult @{
            continue = $true
            systemMessage = "Checkpoint salvo: $relativeMemoryFile"
        }
        exit 0
    }

    if ($eventName -eq 'SessionStart') {
        $source = [string]$hookInput.source
        $contextLines = New-Object 'System.Collections.Generic.List[string]'
        $contextLines.Add("chat_memory: source=$source; session_id=$sessionId; checkpoint=$relativeMemoryFile")

        if ($source -eq 'startup' -or $source -eq 'clear') {
            $candidates = New-Object 'System.Collections.Generic.List[hashtable]'
            if (Test-Path -LiteralPath $memoryRoot -PathType Container) {
                $recentFiles = @(Get-ChildItem -LiteralPath $memoryRoot -Filter '*.md' -File |
                    Sort-Object LastWriteTimeUtc -Descending |
                    Select-Object -First 20)

                foreach ($file in $recentFiles) {
                    $metadata = Get-MemoryMetadata $file
                    if ($null -eq $metadata) {
                        continue
                    }
                    $isCurrent = $metadata.session_id -eq $safeSessionId
                    if ($metadata.status -ne 'active') {
                        continue
                    }
                    if ($isCurrent -and $source -ne 'clear') {
                        continue
                    }

                    $candidates.Add($metadata)
                    if ($candidates.Count -ge 5) {
                        break
                    }
                }
            }

            if ($candidates.Count -gt 0) {
                $contextLines.Add('active_candidates_untrusted_data:')
                foreach ($candidate in $candidates) {
                    $candidatePath = $candidate.path.Substring($resolvedRoot.Length).TrimStart('\', '/').Replace('\', '/')
                    $candidateData = [ordered]@{
                        work = $candidate.work_key
                        project = $candidate.active_project
                        session = $candidate.session_id
                        state = $candidate.checkpoint_state
                        updated = $candidate.updated_at
                        path = $candidatePath
                    }
                    $contextLines.Add(($candidateData | ConvertTo-Json -Compress))
                }
            }
        }

        Write-HookResult @{
            hookSpecificOutput = @{
                hookEventName = 'SessionStart'
                additionalContext = ($contextLines -join [Environment]::NewLine)
            }
        }
        exit 0
    }

    Write-HookResult @{ continue = $true }
}
catch {
    $message = "chat-memory '$eventName' falhou: $($_.Exception.Message)"
    if ($eventName -eq 'PreCompact') {
        Write-HookResult @{
            continue = $false
            stopReason = $message
            systemMessage = $message
        }
    }
    else {
        Write-HookResult @{
            continue = $true
            systemMessage = $message
        }
    }
}
