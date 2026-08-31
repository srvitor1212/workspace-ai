---
name: testing
description: "Analise, crie, ajuste ou execute testes com a infraestrutura existente. Nao adote outro framework sem necessidade e autorizacao."
---

# Testes

Proteja comportamento observavel com testes estaveis e proporcionais ao risco.

## Processo

1. Defina o comportamento, contrato ou regressao a provar e leia as instrucoes aplicaveis.
2. Localize testes semelhantes, framework, fixtures, convencoes e comandos existentes.
3. Use o nivel mais baixo com confianca adequada e cubra caminho principal e limites de entrada, erro, autorizacao, concorrencia e compatibilidade sem multiplicar casos.
4. Teste resultados, nao implementacao. Evite reimplementar o algoritmo ou depender de tempo real, ordem acidental e estado global mutavel.
5. Execute primeiro o conjunto afetado e amplie conforme custo e risco.

Em regressao, confirme quando pratico que o teste falha pela causa esperada antes da correcao e passa depois. Nao altere snapshots ou expectativas para silenciar falhas nem introduza ferramentas ou reestruture a suite sem necessidade.

## Entrega

Diferencie falhas introduzidas, preexistentes e ambientais. Relate testes alterados, comandos, resultados e riscos ainda sem cobertura.
