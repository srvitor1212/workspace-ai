---
name: code-review
description: "Revise diffs, commits ou alteracoes atuais procurando bugs, regressoes, vulnerabilidades, incompatibilidades e testes ausentes. Use para code review; por padrao, reporte achados sem modificar o codigo."
---

# Code review

Avalie o comportamento e o risco das mudancas no projeto ativo. Comentarios esteticos sem impacto pratico nao sao achados.

## Abordagem

1. Defina o conjunto de mudancas e a base de comparacao. Observe instrucoes de review e alteracoes locais preexistentes.
2. Leia o diff e contexto suficiente para compreender contratos, chamadores, persistencia, concorrencia, seguranca e caminhos de erro afetados.
3. Verifique especialmente:
   - comportamento incorreto ou regressao;
   - validacao, autorizacao e exposicao de dados;
   - condicoes de corrida, idempotencia e consistencia;
   - compatibilidade de API, schema, configuracao e deploy;
   - tratamento de falhas, recursos e observabilidade;
   - testes ausentes em comportamentos de risco.
4. Confirme cada achado contra o codigo; nao reporte uma possibilidade abstrata sem um cenario plausivel de falha.
5. Considere o resultado das validacoes existentes, mas nao assuma que testes verdes provam ausencia de regressao.

## Achados

Liste primeiro os achados, ordenados por gravidade:

- `P0`: impacto critico imediato, como perda ampla de dados ou comprometimento;
- `P1`: bug grave ou regressao provavel que bloqueia a entrega;
- `P2`: problema real de impacto moderado;
- `P3`: risco menor, mas concreto e acionavel.

Para cada achado, informe caminho e linha, cenario, impacto e correcao sugerida. Mantenha o intervalo de linhas minimo necessario.

Depois dos achados, registre perguntas ou suposicoes e uma sintese curta. Se nenhum problema for encontrado, diga isso e mencione riscos de teste ou cobertura ainda existentes. Nao edite arquivos sem pedido explicito.
