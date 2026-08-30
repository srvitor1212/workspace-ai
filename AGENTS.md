# Workspace de AI

Este repositório é um workspace genérico para apoiar o desenvolvimento em múltiplos sistemas.

## Estrutura do workspace

- `AGENTS.md`: instruções gerais para a IA trabalhar neste workspace.
- `projects/`: diretório reservado para os repositórios de software usados no workspace.
- `.codex/`: configurações, scripts e recursos auxiliares do workspace.

Cada sistema deve ficar em um diretório próprio dentro de `projects/`. Todo repositório deve conter uma pasta `documentation/` para os documentos do projeto. Por exemplo: `projects/meu-app/documentation/`. O contexto específico de cada sistema deve ser documentado no `AGENTS.md` desse repositório, quando existir.

## Regras gerais

- Nunca altere um repositório diferente daquele solicitado pelo usuário.
- Considere apenas os repositórios localizados em `projects/` como projetos gerenciados por este workspace.
- Antes de trabalhar em um projeto, identifique o diretório correspondente dentro de `projects/` e leia o `AGENTS.md` local, se existir.
- Verifique se o projeto contém a pasta `documentation/`. Em projetos novos, crie essa pasta e adicione nela um `README.md` com uma pequena descrição informando que se trata da pasta de documentação do projeto.
- Leia a documentação daquele repositório na pasta `documentation/`.
- De preferência para ler indices de documentação antes de sair varrendo todo o repositório e assim otimizar o contexto e tokens.
- Se o projeto não tiver um `AGENTS.md`, sugira a criação desse arquivo de contexto, mas isso não deve impedir o trabalho.
- Não adivinhe caminhos de projetos fora de `projects/`. Se o projeto solicitado não estiver lá, peça ao usuário que o disponibilize nesse diretório ou informe o caminho correto.
- Preserve alterações existentes feitas pelo usuário e evite modificar arquivos fora do escopo solicitado.

## Fluxo de trabalho

1. Identificar o projeto solicitado em `projects/`.
2. Ler as instruções deste workspace e o `AGENTS.md` específico do projeto, se disponível.
3. Inspecionar a estrutura e as configurações relevantes antes de fazer alterações.
4. Garantir que a pasta `documentation/` exista; se for um projeto novo, criar também seu `README.md` descritivo.
5. Declarar suposições importantes quando elas afetarem a implementação.
6. Implementar somente o escopo solicitado.
7. Executar verificações e testes adequados ao projeto, quando disponíveis, e relatar os resultados.

## Convenções para novos projetos

- Cada projeto deve ser independente, com seu próprio controle de versão, dependências, documentação e comandos de desenvolvimento.
- A pasta `documentation/` deve concentrar a documentação do projeto e conter um `README.md` explicando seu propósito.
- O `AGENTS.md` de um projeto deve registrar sua linguagem, runtime, framework, comandos principais, estrutura e regras específicas para agentes.
- Instruções específicas de um projeto têm prioridade sobre estas instruções gerais quando não houver conflito com o pedido do usuário.
