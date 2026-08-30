# Instruções do projeto

> Template: adapte este arquivo ao projeto e remova orientações que não se aplicam. Não copie regras sem verificá-las no repositório.

## Contexto

- Propósito do projeto: <!-- descreva em uma ou duas frases -->
- Limites e integrações principais: <!-- informe somente o que estiver verificado -->
- Áreas sensíveis ou fora de escopo: <!-- dados, segurança, legado, componentes externos -->

## Estrutura relevante

- Entrypoints: <!-- caminhos -->
- Código principal: <!-- caminhos -->
- Testes: <!-- caminhos -->
- Índice de documentação: `README-CODEX.md` <!-- ou outro índice leve já adotado -->

## Descoberta de documentação

- Consulte o índice somente quando a tarefa depender de contexto documental.
- Use o índice para escolher documentos por tema; não leia `docs/` inteiro como preparação padrão.
- Se o índice não cobrir a pergunta, busque nomes, títulos ou termos e abra somente os documentos candidatos.
- Ao criar, mover ou remover documentação, atualize o índice sem copiar para ele o conteúdo dos documentos.

## Comandos verificados

- Preparação do ambiente: <!-- comando ou "não documentado" -->
- Build: <!-- comando ou "não aplicável" -->
- Testes direcionados: <!-- comando e forma de filtrar -->
- Testes completos: <!-- comando -->
- Lint, formatação, tipos ou análise estática: <!-- comandos existentes -->

Não invente comandos ausentes. Registre pré-requisitos e diretório de execução quando isso alterar o resultado.

## Convenções e limites

- <!-- padrões arquiteturais que realmente orientam mudanças -->
- <!-- compatibilidade, contratos ou invariantes importantes -->
- <!-- arquivos gerados e como atualizá-los corretamente -->

## Validação e entrega

- Execute primeiro as verificações diretamente relacionadas à mudança.
- <!-- verificações obrigatórias específicas deste projeto -->
- Documente validações não executadas e o risco restante.

## Segurança e operações de alto impacto

- <!-- regras verificadas para dados, secrets, migrations, infraestrutura ou deploy -->
- Solicite autorização antes de uma operação destrutiva ou externa quando a intenção não estiver explícita.

## Code Review Rules

- <!-- riscos concretos que uma revisão deve priorizar neste projeto -->
