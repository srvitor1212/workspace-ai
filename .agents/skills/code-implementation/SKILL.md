---
name: code-implementation
description: Analisa, esclarece e implementa solicitações que exigem criação ou alteração de código. Use para novas funcionalidades, mudanças de comportamento, correções de bugs, refatorações ou alterações em fluxos existentes. Antes de codificar, investigue o contexto necessário, elimine ambiguidades relevantes e confirme com o usuário decisões que não possam ser determinadas com segurança pelo código ou pela documentação existente.
metadata:
  short-description: Refinar requisitos, analisar impacto e implementar alterações de código.
---

# Code Implementation

## Objetivo

A partir de um prompt, transformar a solicitação em uma implementação clara, segura e alinhada com oque é esperado pelo usuário.

## Entendimento inicial

Antes de modificar código, entenda suficientemente:

- quais são os projetos alvo dessa solicitação;
- é uma implementação nova ou alteração de algo que já existe;
- o problema ou objetivo da solicitação;
- o comportamento esperado;
- quais restrições técnicas precisam ser respeitadas;

## Regras dessa Skill

- Não comece a implementação enquanto existirem ambiguidades ou dúvidas técnicas relevantes que possam alterar significativamente a solução.
- Tente esclarecer suas dúvidas primeiro por meio da leitura do código e da documentação disponível, antes de solicitá-las ao usuário. Quando uma decisão for tomada com base no código ou na documentação, descreva-a no chat antes de realizar a implementação.
- Quando uma decisão puder alterar comportamento, arquitetura, contrato, persistência, integração, segurança ou escopo, esclareça-a antes de implementar.

## Fluxo de trabalho

### 1. Entender a solicitação

Interprete o pedido do usuário e identifique:

- quais são os projetos alvo dessa solicitação;
- se é uma implementação nova ou alteração de algo que já existe;
- o problema ou objetivo da solicitação;
- solução sugerida pelo usuário, quando houver.

### 2. Fazer perguntas ao usuário

Quando perguntas forem necessárias:

- seja específico;
- forneça o contexto encontrado;
- explique brevemente por que a decisão importa;
- agrupe perguntas relacionadas quando isso facilitar a resposta;
- evite questionários extensos;
- apresente alternativas quando elas estiverem claras.

### 3. Confirmar entendimento

Antes de implementar uma alteração relevante, tenha clareza suficiente sobre:

- objetivo;
- comportamento esperado;
- escopo;
- componentes afetados;
- decisões técnicas relevantes;
- restrições;

Se o pedido já estiver suficientemente claro após a análise do projeto, não solicite confirmação desnecessária.

### 4. Planejar a alteração

Dentro do projeto-alvo crie um documento que descreva a implementação:

- arquivos ou componentes que serão alterados;
- comportamento que será adicionado ou modificado;
- contratos afetados;
- impactos entre módulos ou serviços;
- testes necessários;
- riscos de regressão;
- regras de negócio que foram inseridas ou modificadas;
- fluxo do sistema que descreve essa funcionalidade;

Para mudanças pequenas e evidentes, não produza planejamento excessivo.
O arquivo com o plano deve ficar em `projects/<nome-do-projeto-alvo>/docs`. 
O nome desse arquivo deve seguir o seguinte padrão `<descrição curta>.md`.
Esse documento deve conter data e hora que foi implementado. 
Crie um arquivo por plano de implementação, sem altera os demais arquivos existentes.
Para mudanças complexas, apresente ao usuário um resumo do plano antes de alterações de alto impacto quando houver decisões relevantes envolvidas.

### 5. Implementar

Ao modificar o código:

- mantenha-se estritamente no escopo da solicitação;
- preserve padrões e convenções existentes;
- evite refatorações não relacionadas;
- não introduza novas dependências sem necessidade;
- considere compatibilidade com fluxos existentes;
- atualize testes relevantes;
- atualize documentação quando a mudança alterar comportamento, contratos ou configuração.

Não aproveite a tarefa para corrigir problemas não relacionados.

Problemas adicionais encontrados podem ser mencionados como sugestões separadas.

### 6. Validar

Após implementar:

- compile o projeto-alvo e garanta que está funcionando com as novas alterações;
- execute ou analise os testes relevantes;
- valide compilação ou verificações disponíveis quando aplicável;
- confirme que os critérios definidos foram atendidos.

Se alguma validação não puder ser executada, informe isso claramente.

## Uso de suposições

Evite suposições silenciosas.

Quando uma suposição for pequena, reversível e consistente com padrões existentes, ela pode ser adotada.

Quando uma suposição puder alterar significativamente comportamento, arquitetura, contrato ou experiência do usuário, ela deve ser esclarecida antes da implementação.

## Resultado esperado

Ao concluir a tarefa, informe de forma objetiva:

- o que foi implementado;
- onde ocorreram as principais alterações;
- decisões relevantes tomadas;
- validações realizadas;
- limitações ou pontos pendentes, quando existirem;
- cite com link as documentações criadas ou atualizadas;