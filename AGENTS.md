# Workspace de IA com Codex

## Objetivo

Apoiar a análise, o planejamento, a implementação e a documentação de sistemas com mudanças rastreáveis, verificáveis e seguras.

## Estrutura

- Os repositórios de trabalho devem estar em `projects/<nome-do-projeto>`.
- A documentação de cada projeto deve ficar em `projects/<nome-do-projeto>/docs`.
- As skills locais do repositório devem ficar em `.agents/skills`.
- Arquivos de configuração, agentes e regras do Codex podem ficar em `.codex`.
- Quando um projeto tiver convenções próprias, documente-as em `projects/<nome-do-projeto>/AGENTS.md`.

## Escopo

- Trabalhe somente nos arquivos do projeto solicitado.
- Preserve alterações pré-existentes do usuário e não modifique arquivos não relacionados.

## Modo de operar

- Entenda a solicitação, identifique o projeto-alvo e procure skills aplicáveis.
- Use uma skill somente quando o pedido corresponder ao seu escopo; leia o `SKILL.md` completo antes de seguir suas instruções.
- Prefira as ferramentas, padrões, scripts e dependências já existentes no projeto.
- Faça a menor alteração necessária para atender ao objetivo e evite refatorações não solicitadas.

## Verificação e entrega

- Após alterações, revise o diff e confirme que não há mudanças não relacionadas.
- Execute os testes, linters, builds ou outras validações relevantes ao tipo de mudança.
- Ajuste a profundidade da verificação ao risco e ao impacto da alteração.
- Na entrega, informe os arquivos alterados, as validações executadas, os resultados e eventuais limitações conhecidas.

## Segurança e dados

- Não exponha segredos, credenciais, tokens ou dados pessoais em commits, logs, relatórios ou respostas.
- Não acesse bancos de dados, serviços externos ou dados sensíveis sem autorização explícita e necessidade para a tarefa.
- Não execute comandos destrutivos ou irreversíveis sem autorização explícita.
- Ao adicionar dependências, avalie origem, necessidade, licença, impacto de segurança e impacto operacional.

## Git e alterações externas

- Preserve o estado atual do repositório e alterações não relacionadas.
- Não crie commits, branches, pull requests, pushes ou publicações sem solicitação explícita.
- Não use operações que descartem alterações, como `git reset --hard` ou `git checkout --`, sem solicitação explícita.
