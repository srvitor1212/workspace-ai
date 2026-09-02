# Instruções do workspace

## Objetivo

Este repositório organiza fluxos de trabalho para desenvolvimento de sistemas com IA. Os repositórios de trabalho ficam em `projects/` e mantêm sua própria documentação.

## Regras gerais

- Trabalhe somente no projeto solicitado.
- Preserve a arquitetura, os padrões e as decisões existentes do projeto.
- Prefira código simples, legível e fácil de manter.
- Antes de alterar arquivos, verifique o estado do Git e leia o contexto do projeto.
- Ao finalizar, revise o diff e informe os arquivos alterados, os testes executados e qualquer limitação.
- Não altere arquivos gerados, como `bin/`, `obj/` ou `.vs/`, salvo solicitação explícita.
- Sugira melhorias encontradas durante a implementação, mas peça aprovação antes de implementá-las quando elas não fizerem parte da tarefa solicitada.

## Como localizar e entender um projeto

1. Confirme qual projeto foi solicitado.
2. Procure, nesta ordem, por `AGENTS.md`, `README.md`, `docs/` e arquivos de solução ou configuração.
3. Leia a documentação do próprio projeto antes de propor alterações.
4. Não use regras ou decisões de outro projeto sem autorização explícita.

Cada repositório dentro de `projects/` deve ter seu próprio `AGENTS.md`. Isso é importante porque o Codex pode ser iniciado diretamente na raiz desse repositório.

## Documentação

- Mantenha a documentação dentro do repositório ao qual ela pertence.
- Atualize `docs/` quando houver mudanças de arquitetura, API, segurança, configuração ou fluxo de execução.
- Registre decisões técnicas relevantes de forma curta e objetiva.

## Banco de dados e segurança

- Não acesse, atualize ou exclua dados ou tabelas sem solicitação explícita do usuário.
- Mesmo quando solicitado, avise sobre o risco e peça uma segunda confirmação antes de executar operações destrutivas ou irreversíveis.
- Nunca exponha senhas, tokens, chaves ou dados pessoais em código, logs, commits ou respostas.

## Logs

- Sugira logs em pontos importantes de decisão quando aplicável.
- Use o nível adequado para a ferramenta de logs do projeto.
- Não registre segredos, credenciais ou dados pessoais.

## Validação

- Execute os testes disponíveis antes de concluir.
- Se não houver testes, execute build, lint ou outra validação apropriada.
- Se alguma validação não puder ser executada, informe o motivo claramente.
