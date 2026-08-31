# Workspace para OpenAI Codex

Camada genérica de governança e ferramentas para trabalhar com repositórios independentes em `projects/`. Regras e documentação de cada aplicação permanecem no próprio projeto.

## Uso rápido

1. Crie a pasta e adicione um projeto:

   ```powershell
   New-Item -ItemType Directory -Force .\projects | Out-Null
   git clone <url> .\projects\MeuProjeto
   ```

2. Inicie o Codex na raiz:

   ```powershell
   codex
   ```

   De outro diretório, use `codex --cd C:\caminho\workspace-ai`. Se o Windows bloquear `codex.ps1`, use `codex.cmd`.

3. Nomeie o projeto no pedido: `Analise a arquitetura de projects/MeuProjeto.`
4. Na primeira sessão após clonar ou alterar `.codex/hooks.json`, execute `/hooks`, revise e autorize a definição.

O Git desta raiz ignora todo `projects/`; cada filho pode manter repositório, branch e histórico próprios.

## Componentes

| Caminho | Função |
| --- | --- |
| `AGENTS.md` | Regras sempre aplicáveis ao workspace |
| `.agents/skills/` | Workflows carregados somente quando selecionados |
| `.codex/hooks.json` | Eventos de memória antes e depois da compactação |
| `.codex/memory/` | Checkpoints curtos e versionáveis por conversa |
| `templates/project/` | Modelos de instruções e índice documental de projeto |
| `scripts/Test-Workspace.ps1` | Validação determinística da estrutura |
| `projects/` | Repositórios independentes, fora do Git desta raiz |

## Projetos e contexto

O caminho explícito no prompt seleciona o projeto; não há cadastro central. Se o alvo for ambíguo, o Codex deve perguntar em vez de percorrer projetos. Para preparar um repositório, preserve instruções existentes e adapte, quando útil, [`templates/project/AGENTS.md`](templates/project/AGENTS.md) e [`templates/project/README-CODEX.md`](templates/project/README-CODEX.md).

| Onde a sessão começa | Contexto automático | Consequência |
| --- | --- | --- |
| Raiz deste workspace | `AGENTS.md` e skills desta raiz | Modo recomendado; instruções do projeto ativo são localizadas explicitamente |
| Dentro de `projects/MeuProjeto` | Instruções e skills do Git interno | A governança externa pode ficar fora da busca ascendente |

Por diretório, `AGENTS.override.md` substitui `AGENTS.md`; instruções mais próximas especializam as anteriores. A cadeia é montada no início da sessão, portanto alterações pedem nova sessão. Veja [AGENTS.md](https://developers.openai.com/codex/guides/agents-md).

### Carregamento progressivo

- O catálogo nativo (`name`, `description`, caminho) é o único índice de skills; somente as selecionadas são abertas.
- Documentação é consultada apenas quando a tarefa exige. No projeto ativo, o Codex usa um índice leve, como `README-CODEX.md`, para escolher poucos documentos.
- Sem índice, a descoberta começa por nomes, títulos ou termos; leitura recursiva fica reservada a auditorias explícitas.
- Código, configuração e testes confirmam afirmações que afetam decisões.

## Skills

| Skill | Uso | Edita por padrão? |
| --- | --- | --- |
| `repository-analysis` | Mapear estrutura e fluxos | Não |
| `implementation-plan` | Produzir plano técnico | Não |
| `implement-change` | Implementar mudança definida | Sim |
| `debugging` | Investigar causa raiz | Somente se solicitado |
| `code-review` | Encontrar defeitos em mudanças | Não |
| `testing` | Criar ou executar testes | Conforme o pedido |
| `documentation` | Atualizar documentação verificada | Conforme o pedido |

Ative uma skill implicitamente pelo pedido ou explicitamente:

```text
$repository-analysis mapeie o fluxo de autenticação em projects/AuthServiceApi.
```

Para uma capacidade reutilizável nova, use `$skill-creator`; mantenha `SKILL.md` curto e mova detalhes condicionais ou automação para recursos internos somente quando necessário.

## Memória entre chats

`SessionStart` fornece `session_id`, caminho do checkpoint e metadados de até cinco memórias candidatas; o Codex pede consentimento antes de carregar uma. `PreCompact` garante um arquivo antes da compactação e a continuação o atualiza semanticamente. Formato, limites e ativação: [`.codex/memory/README.md`](.codex/memory/README.md).

O recurso nativo `/memories` é independente e grava estado global em `~/.codex/memories/`.

## Validação

O validador não instala dependências nem acessa `projects/`. Ele verifica arquivos obrigatórios, frontmatter e nomes das skills, hooks e regras de ignore.

```powershell
# Windows PowerShell 5.1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Test-Workspace.ps1

# PowerShell 7+
pwsh -NoProfile -File .\scripts\Test-Workspace.ps1
```

`Bypass` vale somente para o processo iniciado.

## Limites

- O modo raiz depende da regra que manda localizar instruções dentro do projeto ativo; elas não entram automaticamente na cadeia inicial.
- O modo iniciado no Git interno pode não carregar governança ou skills desta raiz.
- O hook cria o checkpoint antes de compactar, mas não executa outro modelo nem interpreta a transcrição; o Codex mantém o resumo durante o trabalho e o atualiza após compactação.
- A descoberta automática considera os 20 checkpoints mais recentes e oferece até cinco ativos; os demais continuam acessíveis por `session_id`, `work_key` ou caminho.
- O validador confirma estrutura, não qualidade semântica.

## Referências

- [AGENTS.md](https://developers.openai.com/codex/guides/agents-md)
- [Skills](https://developers.openai.com/codex/skills)
- [Hooks](https://developers.openai.com/codex/hooks)
- [Memories](https://developers.openai.com/codex/memories)
- [Configuração](https://developers.openai.com/codex/config-basic)
# AuthApi
# AuthApi
