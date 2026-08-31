# Checkpoints de conversa

Arquivos em `sessions/` são temporários, mas intencionalmente visíveis ao Git. O comportamento obrigatório está em [`AGENTS.md`](../../AGENTS.md); este arquivo define apenas formato e valores.

## Cabeçalho

| Campo | Valor |
| --- | --- |
| `session_id` | ID fornecido por `SessionStart` |
| `work_key` | Issue, branch, ticket ou slug curto |
| `active_project` | Caminho do projeto em escopo |
| `status` | `active`, `completed` ou `abandoned` |
| `checkpoint_state` | `ready` ou `needs-update` |
| `updated_at` | UTC em ISO 8601 |

`SessionStart` só oferece checkpoints `active` com cabeçalho válido, `work_key` e projeto preenchidos. A descoberta lê no máximo 20 cabeçalhos recentes e retorna até cinco candidatos; o corpo só é lido após consentimento.

## Modelo

```markdown
---
session_id: '<id>'
work_key: '<issue, branch, ticket ou slug>'
active_project: '<caminho>'
status: 'active'
checkpoint_state: 'ready'
updated_at: '<UTC ISO 8601>'
---

# Checkpoint da conversa

## Objetivo e estado

## Decisões e restrições

## Mudanças e validações

## Próximos passos e bloqueios
```

Mantenha somente fatos necessários para retomar o trabalho. Não inclua secrets, credenciais, raciocínio interno, transcrição, grandes saídas ou cópias de documentação.
