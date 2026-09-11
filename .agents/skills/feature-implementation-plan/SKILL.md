---
name: feature-implementation-plan
description: Cria ou atualiza um plano detalhado e rastreável de implementação a partir de um documento de requisitos de uma funcionalidade. Use antes de implementar ou para registrar o progresso da implementação; não implemente código.
metadata:
  short-description: Planeja a implementação de uma funcionalidade
---

# Objetivo

Produza um plano de implementação que permita a outra pessoa implementar a
funcionalidade sem precisar rediscutir decisões técnicas ou de escopo. O plano
é derivado do documento de requisitos e mantém o estado do trabalho visível.

## Limites da skill

- Não implemente código, não altere testes do produto e não altere o documento
  de requisitos para preencher lacunas.
- Use como fonte de verdade um documento em
  `projects/<nome-do-projeto-alvo>/docs/features`.
- Se o documento de requisitos não estiver identificado, não estiver completo
  ou ainda contiver dúvida capaz de alterar a solução, pare e peça que ele seja
  definido ou atualizado antes de criar ou concluir o plano.
- Antes de registrar uma decisão técnica, procure a resposta no código, na
  documentação e nas convenções do projeto. Se mais de uma alternativa
  materialmente diferente continuar válida, apresente a dúvida ao usuário; não
  deixe uma decisão em aberto no plano final.

## Fluxo de trabalho

1. **Identifique as entradas e as convenções.** Localize o projeto em
   `projects/<nome-do-projeto-alvo>`, aplique as instruções e convenções já
   identificadas para ele e leia o documento de requisitos escolhido. Consulte
   somente a documentação ou os trechos necessários para fundamentar decisões
   técnicas. Registre o caminho relativo e o título do documento de requisitos
   no plano.

2. **Valide a prontidão dos requisitos.** Confirme que os requisitos
   funcionais, não funcionais, critérios de aceitação, decisões e itens fora do
   escopo necessários existem e não se contradizem. Trate uma pendência que
   mude o comportamento, os dados, permissões, integrações, segurança, migração
   ou validação como bloqueio para o plano final.

3. **Inspecione a base de código.** Investigue apenas as áreas relacionadas à
   funcionalidade. Identifique os pontos reais de entrada, módulos, contratos,
   modelos, persistência, componentes, testes, configurações e documentação
   que serão afetados. Diferencie fatos observados de suposições. Não invente
   arquivos ou padrões quando já houver equivalentes no projeto.

4. **Defina as decisões de implementação.** Explique as escolhas que tornam o
   plano executável: responsabilidade de cada camada, contratos e formatos de
   dados, validações, autorização, erros, efeitos colaterais, compatibilidade,
   migração, observabilidade e estratégia de testes, somente quando aplicáveis.
   Cada decisão deve citar sua origem: requisito, convenção do projeto ou
   evidência no código.

5. **Organize uma ordem executável.** Crie passos numerados e sequenciais,
   pequenos o bastante para acompanhar o progresso. Cada passo deve indicar:
   objetivo, requisitos atendidos, arquivos a criar ou alterar, mudança
   detalhada, trechos decisivos de código ou pseudocódigo, dependências e como
   verificar o resultado. Ordene pré-requisitos antes dos consumidores e testes
   próximos à mudança que validam.

6. **Mapeie a rastreabilidade.** Relacione todo RF, RNF e critério de
   aceitação aplicável a pelo menos um passo e à respectiva validação. Nenhum
   requisito pode depender de uma interpretação não registrada no plano.

7. **Documente e revise.** Crie ou atualize o plano, confira que ele atende a
   todos os requisitos da fonte, que os caminhos de arquivos são precisos e que
   uma pessoa consegue executar os passos na ordem definida. Não inclua
   segredos, dados pessoais ou valores de produção.

## Documento de plano

Crie ou atualize o arquivo em
`projects/<nome-do-projeto-alvo>/docs/feature-implementation-plans`, com o
nome `feat-impl-plan-{aaaammdd-hhmmss}-{descricao-breve}.md`. Use data e hora
em UTC e uma descrição curta, em minúsculas, com palavras separadas por hífen.
Ao atualizar um plano existente, preserve o nome e o histórico.

Use esta estrutura mínima, adaptando somente se a convenção do projeto exigir:

````markdown
# Plano de implementação: <nome da funcionalidade>

> **Estado da implementação:** Plano criado
> **Última atualização (UTC):** YYYY-MM-DD HH:mm:ss UTC
> **Documento de requisitos:** [<nome do documento>](../features/<arquivo>.md)

## Objetivo e escopo

<Objetivo, limites e resultado esperado, consistentes com os requisitos.>

## Contexto técnico atual

<Fluxo e evidências relevantes encontrados na base de código.>

## Decisões de implementação

| ID | Decisão | Origem | Impacto na implementação |
| --- | --- | --- | --- |
| IMP-DEC-001 | ... | RF-001, convenção ou arquivo | ... |

## Arquivos afetados

| Caminho | Ação | Responsabilidade da mudança | Requisitos |
| --- | --- | --- | --- |
| `caminho/arquivo.ext` | Criar, alterar ou remover | ... | RF-001 |

## Ordem de implementação

### 1. <nome do passo>

- [ ] Implementado
- **Objetivo:** ...
- **Requisitos atendidos:** RF-001, RNF-001, CA-RF-001.
- **Arquivos:** `caminho/arquivo.ext` (alterar), `caminho/novo.ext` (criar).
- **Alterações:** descrição detalhada de responsabilidades, regras, contratos,
  falhas e efeitos esperados.
- **Trecho decisivo:**

  ```<linguagem>
  // Pseudocódigo ou trecho indicativo da lógica/contrato decisivo.
  ```

- **Dependências:** passo anterior, migração, configuração ou N/A.
- **Verificação:** teste, comando, cenário ou inspeção observável.

## Estratégia de testes e validação

<Testes automatizados, cenários de aceitação, dados necessários e verificações
manuais, com o requisito atendido por cada item.>

## Rastreabilidade dos requisitos

| Requisito ou critério | Passos | Validação |
| --- | --- | --- |
| RF-001 | 1, 3 | teste ou cenário correspondente |

## Riscos, compatibilidade e implantação

<Migrações, ordem de publicação, rollback, telemetria ou N/A.>

## Itens fora do escopo

<Itens definidos no documento de requisitos.>

## Histórico de alterações

| Data e hora (UTC) | Alteração |
| --- | --- |
| YYYY-MM-DD HH:mm:ss UTC | Plano criado a partir de `<caminho-do-documento-de-requisitos>`. |
````

### Estado e acompanhamento

Mantenha o bloco de estado no topo do documento. Use exclusivamente estes
valores, atualizando também a data e o histórico a cada revisão:

- `Plano criado`: nenhum trabalho de implementação foi iniciado; todos os
  passos ficam desmarcados.
- `Implementação iniciada`: existe trabalho de implementação em andamento.
  Marque como `[x] Implementado` cada passo concluído e mantenha como `[ ]`
  todos os demais. Registre no histórico quais passos foram concluídos ou
  alterados.
- `Implementação completa`: todos os passos aplicáveis estão marcados como
  concluídos e as validações planejadas foram executadas ou possuem resultado
  registrado. Não use esse estado somente porque o código foi alterado.

Caso a implementação revele uma mudança de comportamento ou decisão que não
esteja coberta pelos requisitos, não a aceite silenciosamente no plano. Registre
o impacto e encaminhe a atualização do documento de requisitos antes de marcar
o plano como completo.

## Critérios de qualidade

Antes de entregar, confirme que:

- o documento de requisitos está referenciado por link e caminho;
- todos os requisitos e critérios aplicáveis possuem passos e validações
  rastreáveis;
- os arquivos listados existem ou estão explicitamente identificados como novos;
- as etapas têm ordem clara, detalhes suficientes e trechos decisivos quando
  uma escolha técnica, contrato ou algoritmo exige precisão;
- não há decisões materiais pendentes nem contradições com os requisitos; e
- o estado, checklists e histórico representam o progresso real.

## Entrega

Informe o caminho do plano criado ou atualizado, o documento de requisitos que
o fundamenta, as decisões de implementação principais e eventuais bloqueios.
