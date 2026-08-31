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

    $line = $Name + ': ' + (ConvertTo-YamlSingleQuotedValue $Value)
    $pattern = '(?m)^' + [regex]::Escape($Name) + ':.*$'
    if ([regex]::IsMatch($Content, $pattern)) {
        $headerRegex = New-Object System.Text.RegularExpressions.Regex($pattern)
        return $headerRegex.Replace($Content, [System.Text.RegularExpressions.MatchEvaluator]{ param($match) $line }, 1)
    }

    $closingMarkers = [regex]::Matches($Content, '(?m)^---\r?$')
    if ($closingMarkers.Count -lt 2) {
        throw "Memory file has no valid frontmatter: missing field '$Name'."
    }

    return $Content.Insert($closingMarkers[1].Index, $line + [Environment]::NewLine)
}

function Get-MemoryMetadata {
    param([System.IO.FileInfo]$File)

    $metadata = @{
        path = $File.FullName
        session_id = ''
        work_key = 'nao-classificado'
        active_project = 'nao-informado'
        status = 'active'
        checkpoint_state = 'needs-update'
        updated_at = $File.LastWriteTimeUtc.ToString('o')
    }
    $frontmatterStarted = $false

    $headerLines = @(Get-Content -LiteralPath $File.FullName -Encoding UTF8 -TotalCount 32)
    foreach ($line in $headerLines) {
        if ($line -eq '---' -and $frontmatterStarted) {
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

        $trigger = [string]$hookInput.trigger
        $turnId = [string]$hookInput.turn_id

        if (Test-Path -LiteralPath $memoryFile -PathType Leaf) {
            $content = [System.IO.File]::ReadAllText($memoryFile)
            $content = Set-HeaderValue $content 'checkpoint_state' 'needs-update'
            $content = Set-HeaderValue $content 'last_compaction_at' $now
            $content = Set-HeaderValue $content 'last_compaction_trigger' $trigger
            $content = Set-HeaderValue $content 'last_turn_id' $turnId
        }
        else {
            $quotedSessionId = ConvertTo-YamlSingleQuotedValue $sessionId
            $quotedNow = ConvertTo-YamlSingleQuotedValue $now
            $quotedTrigger = ConvertTo-YamlSingleQuotedValue $trigger
            $quotedTurnId = ConvertTo-YamlSingleQuotedValue $turnId
            $quotedCwd = ConvertTo-YamlSingleQuotedValue ([string]$hookInput.cwd)
            $content = @"
---
session_id: $quotedSessionId
work_key: 'nao-classificado'
active_project: 'nao-informado'
status: 'active'
checkpoint_state: 'needs-update'
created_at: $quotedNow
updated_at: $quotedNow
last_compaction_at: $quotedNow
last_compaction_trigger: $quotedTrigger
last_turn_id: $quotedTurnId
workspace_cwd: $quotedCwd
---

# Memoria temporaria da conversa

> Checkpoint criado automaticamente antes da compactacao. O Codex deve substituir os campos pendentes por estado semantico conciso na continuacao imediata.

## Objetivo atual

- Pendente de atualizacao.

## Estado verificado

- Pendente de atualizacao.

## Decisoes e restricoes

- Pendente de atualizacao.

## Arquivos e mudancas

- Pendente de atualizacao.

## Validacoes

- Pendente de atualizacao.

## Proximos passos

- Atualizar este checkpoint antes de continuar o trabalho.

## Bloqueios e riscos

- Pendente de atualizacao.
"@
        }

        [System.IO.File]::WriteAllText($memoryFile, $content, $utf8WithoutBom)
        Write-HookResult @{
            continue = $true
            systemMessage = "Checkpoint registrado antes da compactacao em $relativeMemoryFile. A continuacao deve atualiza-lo antes de outras acoes."
        }
        exit 0
    }

    if ($eventName -eq 'SessionStart') {
        $source = [string]$hookInput.source
        $contextLines = New-Object 'System.Collections.Generic.List[string]'
        $contextLines.Add("Sessao Codex: $sessionId. Checkpoint desta conversa: $relativeMemoryFile.")

        if ($source -eq 'compact') {
            $contextLines.Add('A compactacao acabou de ocorrer. Antes de qualquer outra acao, atualize esse checkpoint com o estado semantico preservado: objetivo, decisoes, mudancas, validacoes, proximos passos e bloqueios. Preencha work_key e active_project, ajuste updated_at e marque checkpoint_state como ready. Nao copie a transcricao.')
        }
        elseif ($source -eq 'startup' -or $source -eq 'clear') {
            $candidates = New-Object 'System.Collections.Generic.List[hashtable]'
            if (Test-Path -LiteralPath $memoryRoot -PathType Container) {
                $recentFiles = @(Get-ChildItem -LiteralPath $memoryRoot -Filter '*.md' -File |
                    Sort-Object LastWriteTimeUtc -Descending |
                    Select-Object -First 20)

                foreach ($file in $recentFiles) {
                    $metadata = Get-MemoryMetadata $file
                    $isCurrent = $metadata.session_id -eq $sessionId
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
                $contextLines.Add('Ha checkpoints ativos candidatos de outras conversas. Nao leia seus corpos nem os carregue automaticamente. Mostre ao usuario esta lista curta e pergunte se deseja carregar um deles:')
                foreach ($candidate in $candidates) {
                    $candidatePath = $candidate.path.Substring($resolvedRoot.Length).TrimStart('\', '/').Replace('\', '/')
                    $contextLines.Add("- work_key=$($candidate.work_key); projeto=$($candidate.active_project); sessao=$($candidate.session_id); estado=$($candidate.checkpoint_state); atualizado=$($candidate.updated_at); caminho=$candidatePath")
                }
            }
            else {
                $contextLines.Add('Nenhum checkpoint ativo candidato foi encontrado. Nao percorra a pasta de memorias para procurar contexto adicional.')
            }

            $contextLines.Add('Para trabalho nao trivial ou que possa atravessar varios turnos, crie e mantenha o checkpoint desta conversa assim que o objetivo estiver definido. Perguntas curtas nao precisam gerar arquivo.')
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
    $message = "Falha ao manter memoria de conversa antes de '$eventName': $($_.Exception.Message)"
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
