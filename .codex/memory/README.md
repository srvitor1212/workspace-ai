# Memorias temporarias de conversa

Esta pasta guarda checkpoints semanticos curtos para retomar trabalho entre compactacoes ou chats. Ela e intencionalmente versionavel: os arquivos em `sessions/` nao sao ignorados pelo Git.

## Fluxo

1. O hook `SessionStart` informa ao Codex o `session_id` e o caminho reservado para a conversa atual.
2. Em trabalho longo, o Codex cria e atualiza esse arquivo em marcos relevantes, sem esperar a janela de contexto ficar critica.
3. O hook `PreCompact` garante que o arquivo exista antes de uma compactacao manual ou automatica e o marca como `needs-update`.
4. A continuacao imediata depois da compactacao recebe uma instrucao para consolidar o estado preservado e marcar o checkpoint como `ready`.
5. Em um chat novo ou limpo, o hook consulta somente o cabecalho de ate 20 arquivos recentes, apresenta no maximo cinco checkpoints `active` e pede consentimento antes de ler um deles.

Nao ha copia nem parser da transcricao do Codex. Alem de evitar arquivos grandes e conteudo irrelevante, isso nao depende do formato interno e instavel da transcricao.

## Identificacao e ciclo de vida

O nome do arquivo deriva do `session_id`. O cabecalho tambem liga a conversa ao trabalho por:

- `work_key`: issue, branch, ticket ou slug curto da implementacao;
- `active_project`: caminho do projeto em escopo;
- `status`: use `active` enquanto houver trabalho retomavel e `completed` ou `abandoned` quando ele nao deva mais ser oferecido;
- `checkpoint_state`: `ready` quando o corpo representa o estado atual; `needs-update` quando o hook acabou de registrar uma compactacao.

Ao concluir uma tarefa, atualize o estado em vez de apagar automaticamente o arquivo. Isso preserva rastreabilidade e deixa qualquer remocao como decisao explicita.

## Conteudo esperado

Mantenha somente o necessario para continuar corretamente:

- objetivo e escopo atual;
- fatos verificados, decisoes e restricoes;
- arquivos alterados e trabalho concluido;
- validacoes realmente executadas e seus resultados;
- proximo passo concreto, bloqueios e riscos.

Nao armazene secrets, tokens, credenciais, raciocinio interno, transcricoes, grandes saidas de ferramentas ou copias extensas de documentacao. Prefira caminhos e identificadores a conteudo duplicado.

Ao criar um checkpoint antes da primeira compactacao, use esta estrutura e substitua os marcadores:

```markdown
---
session_id: '<id fornecido pelo hook>'
work_key: '<issue, branch, ticket ou slug>'
active_project: '<caminho do projeto ou workspace>'
status: 'active'
checkpoint_state: 'ready'
created_at: '<data UTC ISO 8601>'
updated_at: '<data UTC ISO 8601>'
last_compaction_at: ''
last_compaction_trigger: ''
last_turn_id: ''
workspace_cwd: '<raiz do workspace>'
---

# Memoria temporaria da conversa

## Objetivo atual

## Estado verificado

## Decisoes e restricoes

## Arquivos e mudancas

## Validacoes

## Proximos passos

## Bloqueios e riscos
```

## Ativacao

Hooks locais so executam depois que este projeto e confiavel e a definicao atual foi revisada. Em uma sessao nova, use `/hooks`, revise `.codex/hooks.json` e autorize os dois eventos. Toda mudanca futura na definicao exige nova revisao por hash.

O recurso nativo `/memories` do Codex pode ser usado em paralelo, mas e independente: ele armazena estado gerado em `~/.codex/memories/` e nao substitui estes checkpoints versionaveis e vinculados ao workspace.
