# Workspace de IA com Codex

## Objetivo

Apoiar a análise, o planejamento, a implementação, a padronização e a documentação de sistemas com mudanças rastreáveis, verificáveis e seguras. Este  é um repositório de governança e não de aplicação.

## Estrutura

- Os repositórios de trabalho devem estar em `projects/<nome-do-projeto-alvo>`.
- A documentação de cada projeto-alvo deve ficar em `projects/<nome-do-projeto-alvo>/docs`.
- As skills locais do repositório devem ficar em `.agents/skills`.
- Arquivos de configuração, agentes e regras do Codex podem ficar em `.codex/`.
- Depois de identificar o projeto-alvo, leia o `AGENTS.md` e `README.md` dele, quando existir.

## Escopo

- Trabalhe somente nos arquivos do projeto-alvo solicitado.
- Preserve alterações pré-existentes do usuário e não modifique arquivos não relacionados.

## Modo de operar

- Entenda a solicitação, identifique o projeto-alvo e procure skills aplicáveis.
- Se a solicitação do usuário tiver ambiguidades que possam alterar materialmente o resultado, antes de agir tire as dúvidas com ele de forma objetiva.
- Não faça perguntas para detalhes triviais; quando possível, adote uma suposição razoável e informe-a ao usuário.
- Use uma skill somente quando o pedido corresponder ao seu escopo; leia o `SKILL.md` completo antes de seguir suas instruções.
- Prefira as ferramentas, padrões, scripts e dependências já existentes no projeto-alvo.
- Faça a menor alteração necessária para atender ao objetivo e evite refatorações não solicitadas.
- Não execute ações destrutivas, irreversíveis ou fora do escopo sem confirmação explícita.

## Leitura de repositórios de trabalho (projeto-alvo)

- Em buscas amplas, ignore artefatos gerados, dependências instaladas e metadados de ferramentas como: `.git`, `.vs`, `bin`, `obj`, `node_modules`, `dist`, `build`, `out`, `coverage`, `TestResults`, `__pycache__`, `.pytest_cache`, `.mypy_cache`, `.gradle`, `target` e `.terraform`.
- Respeite o `.gitignore` do projeto-alvo quando fizer exploração geral e use exclusões equivalentes nas ferramentas de busca.
- Não ignore por padrão `.agents`, `.codex`, `AGENTS.md`, `README.md`, `docs` ou arquivos de configuração do projeto-alvo.
- Leia uma pasta ignorada somente quando a tarefa envolver build, cache, dependências, IDE, diagnóstico de ambiente ou outro motivo explícito.
- Ao investigar uma pasta ignorada, leia apenas os arquivos necessários e não trate artefatos gerados como fonte oficial do código.
- Consulte o a documentação do projeto-alvo de forma dirigida, somente quando acrescentarem contexto necessário à tarefa; use títulos, buscas e trechos relevantes, sem releitura de arquivos já presentes no contexto.

## Segurança e dados

- Não exponha segredos, credenciais, tokens ou dados pessoais em commits, logs, relatórios ou respostas.
- Não acesse bancos de dados, serviços externos ou dados sensíveis sem autorização explícita e necessidade para a tarefa.
- Não execute comandos destrutivos ou irreversíveis sem autorização explícita.
- Ao adicionar dependências, avalie origem, necessidade, licença, impacto de segurança e impacto operacional.

## Datas, horários e fusos

- Prefira sempre representações de data e hora que preservem o deslocamento de fuso horário.
- Para registrar o instante atual, use sempre o horário universal coordenado (UTC), evitando o horário local da máquina.
- Converta horários para o fuso local somente na apresentação ao usuário, nunca como regra interna de armazenamento ou processamento.

## Git e alterações externas

- Preserve o estado atual do repositório e alterações não relacionadas.
- Não crie commits, branches, pull requests, pushes ou publicações sem solicitação explícita.
- Não use operações que descartem alterações, como `git reset --hard` ou `git checkout --`, sem solicitação explícita.
