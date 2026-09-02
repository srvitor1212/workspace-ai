---
name: code-steps
description: Implementa uma ou mais etapas de um plano de implementação confirmado, uma etapa por vez, pausando para o usuário testar e confirmar antes de continuar.
metadata:
  short-description: Implementa etapas com validação do usuário
---

# Codar Steps

Implemente etapas de um plano de implementação existente. Esta skill pode alterar o código do repositório de trabalho, mas deve avançar de forma incremental e controlada.

## Quando usar

Use quando o usuário pedir para codar uma etapa, implementar um step, começar a implementação de um plano ou continuar a implementação de etapas.

## Pré-requisitos

1. Localize o arquivo de implementação em `analyses/` que está sendo discutido no chat.
2. Se houver mais de um plano possível ou nenhuma referência clara, pergunte ao usuário qual arquivo deve ser usado. Nunca escolha por suposição.
3. Confirme que o plano foi criado pela skill `implementation-plan` e leia o plano completo.
4. Leia a análise de origem, o `AGENTS.md`, o `README.md` e a documentação relevante do repositório.
5. Leia o estado atual do código e verifique o estado do Git antes de alterar qualquer arquivo.

Se o plano de implementação não existir, explique que ele é obrigatório e sugira usar `$implementation-plan` antes de codar.

## Escolha das etapas

Se o usuário não indicar as etapas, pergunte qual etapa deseja implementar. Por padrão começar da primeira até a última uma por vez. Se indicar uma etapa, implemente somente essa etapa. Se pedir várias etapas, implemente apenas o conjunto solicitado, mantendo as etapas separadas e verificáveis.

Mesmo quando várias etapas forem solicitadas, pare ao final do conjunto e peça confirmação de que as alterações foram testadas e que pode continuar. Nunca avance para etapas não autorizadas automaticamente.

## Implementação incremental

Para cada etapa autorizada:

1. Releia o objetivo, as alterações previstas e a forma de validação da etapa.
2. Implemente somente o escopo da etapa.
3. Não crie testes unitários durante a implementação desta etapa.
4. Execute as validações existentes apropriadas, sem substituir o teste do usuário.
5. Revise o diff e informe os arquivos alterados, o que foi feito e como testar.
6. Pare e pergunte ao usuário se ele testou a etapa e se autoriza continuar.

Se a validação falhar, corrija somente a etapa atual. Não avance enquanto o resultado não estiver compreendido e o usuário não confirmar.

## Mudanças de escopo

Se a implementação exigir uma mudança de escopo, decisão ou arquitetura que não esteja no plano:

1. Pare antes de implementar a mudança.
2. Explique a decisão original, a nova necessidade e o impacto.
3. Peça confirmação explícita do usuário.
4. Depois da confirmação, registre a mudança no rodapé do arquivo de implementação.
5. Só então continue a etapa afetada.

Use este formato para cada alteração confirmada:

```markdown
## Ajustes de percurso

### Etapa N — Título da alteração

- Motivo:
- Decisão anterior:
- Nova decisão:
- Impacto:
- Data:
```

Se a seção `## Ajustes de percurso` já existir, acrescente uma nova subseção sem apagar registros anteriores.

## Commits e encerramento

Não crie commits automaticamente. Ao final de cada conjunto de etapas e no fim do plano, verifique o diff e os commits relevantes com os comandos apropriados do repositório.

Quando todas as etapas do plano forem concluídas:

1. Faça uma revisão final do diff e dos commits inseridos.
2. Informe o resumo das etapas concluídas e das validações realizadas.
3. Sugira a criação de testes unitários.
4. Pergunte se o usuário confirma a criação dos testes.
5. Só implemente os testes unitários depois da confirmação explícita.

Até essa confirmação, não crie nem altere testes unitários.
