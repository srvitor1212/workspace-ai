---
name: feature-implementation
description: Implementa novas funcionalidades ou mudanças de comportamento em um projeto, executa as validações relevantes e atualiza a documentação ao final. Use para pedidos de implementação; não use em tarefas explicitamente limitadas a planejamento, revisão ou documentação sem alteração de código.
metadata:
  short-description: Implementa funcionalidades e documenta o resultado
---

# Implementação de funcionalidades

Conduza o pedido desde a compreensão do requisito até uma alteração validada e
documentada. Trabalhe somente no projeto solicitado e preserve alterações
existentes que não façam parte do escopo.

## Fluxo

1. Leia o `AGENTS.md` aplicável, começando pela raiz e seguindo as regras do
   projeto-alvo. Identifique o projeto em `projects/<nome-do-projeto>` e leia
   sua documentação relevante.
2. Converta o pedido em critérios de aceite observáveis. Faça uma pergunta
   somente se uma ambiguidade puder mudar materialmente a implementação;
   caso contrário, adote uma suposição razoável e registre-a na entrega.
3. Inspecione a implementação existente, testes, configurações e padrões
   próximos da área afetada. Reutilize as convenções e dependências já
   presentes antes de propor novas estruturas.
4. Implemente a menor mudança coerente com os critérios de aceite. Evite
   refatorações não solicitadas, alterações fora do projeto e mudanças
   irreversíveis.
5. Execute as validações relevantes, priorizando testes focados e depois os
   testes, linters ou builds indicados pelas instruções do projeto. Corrija
   falhas relacionadas à mudança quando isso estiver dentro do escopo.
6. Ao final da implementação e das validações, revise a documentação existente em
   `projects/<nome-do-projeto>/docs` para identificar arquivos afetados pelo
   comportamento entregue. Crie a documentação necessária e atualize os documentos
   existentes que tenham se tornado incompletos ou desatualizados. Documente o
   comportamento entregue, a forma de uso ou configuração, decisões importantes,
   validações executadas e limitações ou migrações necessárias. Siga o formato e o
   idioma existentes. Ao alterar um documento existente, mantenha ou acrescente no
   rodapé a seção `## Histórico de alterações`, usando este formato e preservando os
   registros anteriores:

   ```markdown
   | Data e hora (UTC) | Alteração |
   | --- | --- |
   | YYYY-MM-DD HH:mm:ss UTC | Descrição concisa do que mudou. |
   ```

   Registre o instante em UTC, sempre com hora, minuto e segundo.
7. Revise o diff completo e confirme que os arquivos alterados pertencem ao
   pedido. Verifique também formatação, testes e documentação antes de relatar
   a conclusão.

## Limites

- Se o usuário pedir apenas um plano, revisão ou documentação, respeite esse
  limite e não implemente código.
- Não crie commits, branches, pull requests, pushes ou publicações sem pedido
  explícito.
- Não exponha segredos, credenciais ou dados pessoais em código, documentação,
  logs ou resposta.
- Não acesse serviços externos, bancos de dados ou ambientes de produção sem
  necessidade clara e autorização no escopo da tarefa.
- Se uma validação não puder ser executada, informe o comando, o motivo e o
  impacto da limitação na entrega.
