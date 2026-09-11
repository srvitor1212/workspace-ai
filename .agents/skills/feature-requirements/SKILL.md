---
name: feature-requirements
description: Analisa o fluxo atual de uma funcionalidade, resolve com o usuário as dúvidas que afetam seu comportamento e produz requisitos funcionais e não funcionais testáveis para um projeto-alvo. Use antes da implementação; não implemente código.
metadata:
  short-description: Levanta requisitos para uma funcionalidade
---

# Objetivo

Ajude o usuário a entender o fluxo atual da funcionalidade que será alterada e
a criar um documento com o comportamento atual, a mudança necessária e os
requisitos para atendê-la.

## Limites da skill

- Não implemente código, não altere testes do produto e não faça refatorações.
- Se o pedido também incluir implementação, conclua o levantamento e informe
  qual documento deve ser usado como entrada para a etapa de implementação.

## Fluxo de trabalho

1. **Identifique o escopo.** Localize o projeto em
   `projects/<nome-do-projeto-alvo>`. Antes de definir os requisitos, leia o
   `AGENTS.md` da raiz, o `AGENTS.md` do projeto-alvo, o `README.md` e a
   documentação relevante. Se não for possível identificar o projeto-alvo ou
   houver uma dúvida que possa mudar o resultado de forma relevante, pergunte ao usuário antes de continuar.

2. **Reconstrua o fluxo atual com evidências.** Inspecione somente a parte
   relevante do projeto. Priorize endpoints, telas, casos de uso, serviços,
   persistência, eventos, integrações, autorização, tratamento de erros e
   testes existentes. Registre o fluxo passo a passo, os atores, as entradas e
   saídas, os estados alterados e as regras encontradas. Diferencie fatos
   confirmados no código ou na documentação de inferências.

3. **Defina a mudança.** Descreva com clareza:
   - o fluxo atual que será alterado; use `N/A` se ele não existir;
   - o objetivo e o problema que a funcionalidade resolve;
   - os atores, gatilhos e cenários de uso;
   - o comportamento novo, o comportamento mantido e o comportamento removido;
   - os dados, estados, permissões, integrações e mensagens afetados;
   - os impactos em compatibilidade, migração, operação e documentação;
   - o que fica fora do escopo e as suposições que precisam ser validadas.

4. **Resolva as dúvidas antes de documentar.** Identifique as dúvidas que
   possam deixar indefinidos o comportamento, o escopo, uma regra de negócio,
   os dados, as permissões, as integrações, o tratamento de erros, os critérios
   de aceitação ou uma métrica não funcional. Primeiro, procure a resposta no
   código e na documentação. Se a dúvida continuar, apresente todas as dúvidas
   ao usuário em uma única mensagem. Para cada uma, informe o contexto ou a
   evidência, as opções conhecidas, se houver, e o impacto de cada resposta.

   Não crie ou atualize o documento de requisitos, não defina requisitos finais
   e não informe que a funcionalidade está pronta para implementação enquanto
   houver uma dessas dúvidas. Depois da resposta do usuário, registre a escolha
   como uma decisão, com data e hora em UTC, origem e impacto. Atualize os
   fluxos, requisitos e critérios de aceitação afetados pela decisão.

5. **Compare o estado atual com o desejado.** Explique as diferenças entre os
   fluxos e indique quais partes do sistema serão afetadas. Não defina uma
   solução técnica quando mais de uma solução puder atender ao mesmo requisito.
   Descreva o comportamento que deve ser observado e as restrições que de fato
   existem.

6. **Especifique os requisitos.** Crie requisitos funcionais (`RF-001`,
   `RF-002`, ...) e não funcionais (`RNF-001`, `RNF-002`, ...). Cada requisito
   deve tratar de um único assunto, ser necessário, claro e verificável. Sempre
   que possível, informe a condição ou o gatilho, o comportamento esperado, o
   resultado e a regra de negócio. Para requisitos não funcionais, informe a
   métrica, o limite, o contexto e como verificar. Se algum valor ainda não for
   conhecido, registre uma pendência em vez de usar termos vagos, como “rápido”
   ou “seguro”.

7. **Defina como validar.** Para cada requisito, escreva critérios de
   aceitação observáveis e, quando for útil, cenários neste formato:
   `Dado ... Quando ... Então ...`. Cubra o caminho principal, validações,
   erros, permissões, casos de limite e compatibilidade somente quando forem
   relevantes para o fluxo. Relacione cada requisito à evidência do fluxo atual
   ou à decisão que motivou a mudança.

8. **Documente o resultado.** Crie ou atualize um arquivo em
   `projects/<nome-do-projeto-alvo>/docs/features`. Use o nome
   `feat-req-{aaaammdd-hhmmss}-{descricao-breve}.md`, em que
   `{descricao-breve}` é uma descrição curta em minúsculas, com palavras
   separadas por hífen. O documento deve conter, no mínimo:
   - contexto, objetivo e escopo;
   - fluxo atual, com evidências;
   - fluxo desejado e comparação das mudanças;
   - requisitos funcionais;
   - requisitos não funcionais;
   - critérios de aceitação e rastreabilidade;
   - decisões tomadas, com origem e impacto;
   - itens fora do escopo e suposições validadas;
   - impactos, dependências e migrações;
   - histórico de alterações, com data e hora em UTC, caso o documento já
     existir ou for revisado.

   Ao atualizar um documento existente, preserve o histórico anterior e
   acrescente uma linha à seção `## Histórico de alterações` neste formato:

   ```markdown
   | Data e hora (UTC) | Alteração |
   | --- | --- |
   | YYYY-MM-DD HH:mm:ss UTC | Descrição curta do levantamento ou da revisão. |
   ```

   Crie a seção `## Decisões tomadas` depois de `## Requisitos não funcionais`
   e antes de `## Impactos, dependências e migrações`. A seção deve ficar fora
   de blocos de código e seguir este formato completo:

   ```markdown
   ## Decisões tomadas

   | ID | Data e hora (UTC) | Decisão | Origem | Impacto |
   | --- | --- | --- | --- |
   | DEC-001 | YYYY-MM-DD HH:mm:ss UTC | Decisão adotada. | Usuário, código ou documentação | Requisitos e fluxos afetados. |
   ```

   Use uma única linha por decisão. Não inclua quebras de linha nas células e
   substitua `|` no texto por vírgula ou `\|`, para não quebrar a tabela. Ao
   atualizar um documento que já tenha essa seção, mantenha o cabeçalho e o
   separador existentes e acrescente somente as novas decisões. Não crie uma
   segunda seção ou uma segunda linha de cabeçalho.

   Se a decisão vier do usuário, registre-a como `Usuário`. Não apresente uma
   inferência como se fosse uma decisão do usuário.

9. **Revise a qualidade.** Confirme que cada requisito trata de um único
   assunto, tem critério de aceitação, não contradiz o fluxo nem outro
   requisito, está ligado ao objetivo da funcionalidade e não contém uma
   decisão técnica sem justificativa. Verifique também que nenhuma informação
   sensível foi copiada para a documentação e que as alterações ficaram
   restritas ao projeto-alvo. Confirme que não há dúvidas pendentes que possam
   alterar o comportamento da funcionalidade e que todas as escolhas do usuário
   estão registradas como decisões. Verifique também que há apenas uma seção
   `## Decisões tomadas`, que ela está fora de blocos de código, fica entre as
   seções de requisitos e impactos e contém uma tabela com cabeçalho, separador
   e uma linha para cada decisão.

## Estrutura recomendada para os requisitos

Use uma tabela ou seções equivalentes, conforme a convenção do projeto:

| ID | Requisito | Critério de aceitação | Evidência ou origem |
| --- | --- | --- | --- |
| RF-001 | O sistema deve ... | Dado ... Quando ... Então ... | Arquivo, tela, regra ou decisão |

Para cada `RNF`, prefira a estrutura abaixo:

`O sistema deve [comportamento mensurável] em [contexto], com verificação por [método].`

As categorias possíveis incluem desempenho, segurança, disponibilidade,
acessibilidade, observabilidade, compatibilidade, privacidade e facilidade de
manutenção. Inclua apenas as categorias relacionadas à funcionalidade.

## Entrega

Depois de resolver todas as dúvidas que afetam o comportamento, informe o
caminho do documento criado ou atualizado, um resumo das principais decisões e
as evidências consultadas. Se o usuário ainda não responder a uma dúvida, não
crie nem atualize o documento. Informe as dúvidas necessárias para continuar e
deixe claro que a funcionalidade não está pronta para implementação.
