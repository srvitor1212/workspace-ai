---
name: code-review
description: "Revise diffs ou commits por bugs, regressoes, seguranca, incompatibilidades e testes ausentes. Reporte achados; nao edite sem pedido."
---

# Code review

Avalie comportamento e risco; estilo sem impacto pratico nao e achado.

## Processo

1. Defina mudancas e base de comparacao; preserve trabalho local e siga regras de review.
2. Leia diff e contexto suficiente de contratos, chamadores, dados, concorrencia, seguranca e erros.
3. Procure regressao; falhas de validacao/autorizacao; exposicao de dados; corrida, idempotencia ou consistencia; incompatibilidade de API, schema, configuracao ou deploy; recursos, observabilidade e testes ausentes.
4. Confirme cada achado com um cenario plausivel. Testes verdes sao evidencia, nao prova de ausencia de regressao.

## Achados

Ordene por gravidade: `P0` critico imediato; `P1` grave ou bloqueador provavel; `P2` impacto moderado; `P3` menor, concreto e acionavel.

Para cada achado, informe caminho e linha minima, cenario, impacto e correcao. Depois registre duvidas ou suposicoes e uma sintese. Sem achados, diga isso e indique riscos de teste ou cobertura. Nao edite sem pedido.
