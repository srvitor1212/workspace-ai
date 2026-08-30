---
name: implement-change
description: "Implemente uma mudanca de software ja definida, incluindo funcionalidade, refatoracao focada ou correcao com causa conhecida. Use para editar e validar codigo; use debugging primeiro quando a causa do problema ainda for incerta."
---

# Implementar mudanca

Entregue a menor alteracao completa que satisfaca o pedido e se integre ao projeto ativo.

## Workflow

1. Confirme o comportamento esperado, o limite da mudanca e as instrucoes aplicaveis.
2. Inspecione o estado do Git e a implementacao, testes e contratos diretamente relacionados. Preserve trabalho local existente.
3. Escolha uma abordagem compativel com os padroes atuais e explicite apenas decisoes ou riscos relevantes.
4. Edite de forma incremental. Evite dependencias novas, abstracoes especulativas e limpeza sem relacao com o pedido.
5. Adicione ou ajuste testes quando o comportamento mudou e houver uma forma estavel de protege-lo.
6. Execute primeiro testes ou verificacoes direcionadas; amplie para build, lint, tipos ou suites maiores conforme o risco.
7. Revise o diff em busca de mudancas acidentais, incompatibilidades, tratamento de erros e documentacao afetada.

Se uma validacao falhar, determine se a falha foi introduzida pela mudanca antes de ampliar o escopo. Nao corrija problemas preexistentes sem autorizacao; registre-os separadamente.

## Conclusao

Informe:

- comportamento implementado e principais arquivos alterados;
- validacoes executadas e seus resultados;
- validacoes nao executadas e o motivo;
- riscos residuais, suposicoes ou proximos passos realmente necessarios.
