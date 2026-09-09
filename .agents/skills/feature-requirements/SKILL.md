---
name: feature-requirements
description: Analisa o fluxo atual de uma funcionalidade, identifica mudanças de comportamento e produz requisitos funcionais e não funcionais testáveis para um projeto-alvo. Use antes da implementação; não implemente código.
metadata:
  short-description: Levanta requisitos para uma funcionalidade
---

# Levantamento de requisitos de funcionalidades

Conduza uma etapa de descoberta que transforme uma solicitação de mudança em
requisitos claros, verificáveis e rastreáveis. O resultado deve permitir que
outra pessoa implemente e valide a funcionalidade sem precisar redescobrir o
fluxo atual.

## Limite da skill

- Analise o comportamento existente e especifique o comportamento desejado.
- Produza ou atualize a documentação de requisitos do projeto-alvo.
- Não implemente código, não altere testes de produto e não faça refatorações.
- Não invente regras, metas de desempenho ou integrações. Quando uma decisão
  for necessária e não estiver disponível, registre-a como suposição ou
  questão em aberto.
- Se o pedido incluir implementação, conclua o levantamento e deixe explícita a
  documentação que deve ser usada como entrada da etapa de implementação.

## Fluxo de trabalho

1. **Identifique o escopo.** Localize o projeto em
   `projects/<nome-do-projeto-alvo>`. Leia o `AGENTS.md` da raiz, o
   `AGENTS.md` do projeto-alvo, o `README.md` e a documentação relevante antes
   de formular requisitos. Se o projeto-alvo não puder ser identificado ou se
   houver uma ambiguidade que altere materialmente o resultado, faça uma única
   pergunta objetiva antes de continuar.

2. **Reconstrua o fluxo atual com evidências.** Inspecione somente a área
   relevante do projeto, priorizando endpoints, telas, casos de uso, serviços,
   persistência, eventos, integrações, autorização, tratamento de erros e
   testes existentes. Registre o fluxo passo a passo, os atores envolvidos,
   entradas e saídas, estados alterados e regras observadas. Diferencie fatos
   confirmados no código ou na documentação de inferências.

   Em buscas amplas, respeite o `.gitignore` e ignore artefatos gerados,
   dependências e caches, como `.git`, `bin`, `obj`, `node_modules`, `dist`,
   `build`, `coverage` e equivalentes.

3. **Defina a mudança.** Separe claramente:

   - objetivo e problema que a funcionalidade resolve;
   - atores, gatilhos e cenários de uso;
   - comportamento novo, comportamento mantido e comportamento removido;
   - dados, estados, permissões, integrações e mensagens afetados;
   - impactos em compatibilidade, migração, operação e documentação;
   - fora de escopo, suposições e questões em aberto.

4. **Compare o estado atual com o desejado.** Explique as lacunas entre os
   dois fluxos e aponte os pontos do sistema que serão afetados. Não prescreva
   uma implementação quando várias soluções atenderem ao mesmo requisito;
   descreva a necessidade observável e as restrições que realmente existem.

5. **Especifique os requisitos.** Crie requisitos funcionais (`RF-001`,
   `RF-002`, ...) e não funcionais (`RNF-001`, `RNF-002`, ...). Cada requisito
   deve ser atômico, necessário, sem ambiguidade e verificável. Sempre que
   possível, inclua condição ou gatilho, comportamento esperado, resultado e
   regra de negócio. Para requisitos não funcionais, inclua métrica, limite,
   contexto e forma de verificação; se o valor ainda não for conhecido,
   registre-o como pendência em vez de usar adjetivos vagos como “rápido” ou
   “seguro”.

6. **Relacione a validação.** Para cada requisito, escreva critérios de
   aceitação observáveis e, quando útil, cenários no formato:
   `Dado ... Quando ... Então ...`. Cubra caminho feliz, validações, erros,
   permissões, estados limítrofes e compatibilidade somente quando forem
   pertinentes ao fluxo. Relacione cada requisito à evidência do fluxo atual ou
   à decisão que originou a mudança.

7. **Documente o resultado.** Prefira a convenção já existente em
   `projects/<nome-do-projeto-alvo>/docs`. Se não houver uma convenção,
   crie o documento em
   `projects/<nome-do-projeto-alvo>/docs/requisitos/<slug-da-feature>.md`.
   O documento deve conter, no mínimo:

   - contexto, objetivo e escopo;
   - fluxo atual, com evidências e incertezas;
   - fluxo desejado e comparação das mudanças;
   - requisitos funcionais;
   - requisitos não funcionais;
   - critérios de aceitação e rastreabilidade;
   - fora de escopo, suposições e questões em aberto;
   - impactos, dependências, migrações ou decisões pendentes;
   - histórico de alterações, com data e hora em UTC, se o documento já
     existir ou for revisado.

   Ao alterar um documento existente, preserve o histórico anterior e acrescente
   uma linha à seção `## Histórico de alterações` neste formato:

   ```markdown
   | Data e hora (UTC) | Alteração |
   | --- | --- |
   | YYYY-MM-DD HH:mm:ss UTC | Descrição concisa do levantamento ou revisão. |
   ```

8. **Faça uma revisão de qualidade.** Confirme que cada requisito tem um único
   propósito, possui critério de aceitação, não contradiz o fluxo ou outro
   requisito, está ligado ao objetivo da feature e não contém decisão técnica
   sem justificativa. Revise também se nenhuma informação sensível foi copiada
   para a documentação e se a alteração ficou restrita ao projeto-alvo.

## Estrutura recomendada para os requisitos

Use uma tabela ou seções equivalentes, conforme a convenção do projeto:

| ID | Requisito | Critério de aceitação | Evidência ou origem |
| --- | --- | --- | --- |
| RF-001 | O sistema deve ... | Dado ... Quando ... Então ... | Arquivo, tela, regra ou decisão |

Para cada `RNF`, prefira explicitar:

`O sistema deve [comportamento mensurável] sob [contexto], com verificação por [método].`

Categorias possíveis incluem desempenho, segurança, disponibilidade,
acessibilidade, observabilidade, compatibilidade, privacidade e
manutenibilidade. Inclua somente categorias que tenham relação com a feature.

## Entrega

Informe o caminho do documento criado ou atualizado, um resumo das principais
decisões, as questões em aberto e as evidências consultadas. Não relate uma
feature como pronta para implementação quando houver uma pendência que impeça
definir seu comportamento; destaque essa pendência para decisão do usuário.
