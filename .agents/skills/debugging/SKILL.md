---
name: debugging
description: "Investigue bugs e comportamentos inesperados por reproducao, evidencias, hipoteses e causa raiz. Corrija somente quando solicitado."
---

# Debugging

Investigue por hipoteses testaveis; nao altere codigo ao acaso.

## Investigacao

1. Separe sintoma de comportamento esperado, ambiente, frequencia e impacto.
2. Busque a reproducao minima; se inviavel, defina evidencias que confirmem ou refutem hipoteses.
3. Colete logs, erros, stack traces, entradas e estado relevantes sem expor dados sensiveis.
4. Trace a execucao e ordene poucas hipoteses por plausibilidade e poder explicativo.
5. Teste uma variavel por vez, registre evidencias e descarte hipoteses refutadas.
6. Declare causa raiz somente se explicar o sintoma e houver evidencia; caso contrario, apresente a incerteza restante.

## Correcao autorizada

Aplique a menor correcao na causa. Quando pratico, prove a regressao antes, repita a reproducao depois e execute verificacoes proporcionais; nao refatore areas alheias.

## Entrega

Relate sintoma e reproducao, hipoteses e evidencias, causa confirmada ou incerteza, correcao/teste quando solicitados e limitacoes.
