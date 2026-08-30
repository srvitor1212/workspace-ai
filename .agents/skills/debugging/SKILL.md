---
name: debugging
description: "Investigue bugs, falhas intermitentes, erros e comportamento inesperado por reproducao, evidencias, hipoteses e causa raiz. Use para diagnosticar; modifique o codigo somente se o usuario tambem pedir a correcao."
---

# Debugging

Conduza a investigacao como uma sequencia de hipoteses testaveis. Nao altere codigo aleatoriamente para procurar uma solucao.

## Investigacao

1. Separe o sintoma observado do comportamento esperado, ambiente, frequencia e impacto.
2. Procure a reproducao minima. Se nao for possivel reproduzir, identifique quais evidencias ainda podem confirmar ou refutar hipoteses.
3. Colete logs, mensagens de erro, stack traces, entradas e estado relevantes sem expor secrets ou dados sensiveis.
4. Trace o caminho de execucao envolvido e formule poucas hipoteses ordenadas por plausibilidade e poder explicativo.
5. Teste uma variavel por vez e registre evidencia favoravel ou contraria. Descarte hipoteses refutadas.
6. Declare a causa raiz apenas quando ela explicar o sintoma e estiver apoiada por evidencia; caso contrario, apresente a conclusao como hipotese restante.

## Correcao, quando autorizada

- Aplique a menor correcao na causa, nao apenas no sintoma.
- Crie uma verificacao de regressao que falhe pelo motivo correto antes da correcao, quando isso for pratico.
- Execute a reproducao original, os testes direcionados e verificacoes mais amplas proporcionais ao risco.
- Nao aproveite a investigacao para refatorar areas nao relacionadas.

## Relato

Diferencie claramente:

- sintoma e reproducao;
- hipoteses avaliadas;
- evidencias coletadas;
- causa raiz confirmada ou incerteza restante;
- correcao e teste de regressao, se solicitados;
- limitacoes do diagnostico.
