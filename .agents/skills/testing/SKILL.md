---
name: testing
description: "Analise, crie, ajuste ou execute testes de software usando a infraestrutura existente do projeto. Use para proteger comportamentos e validar mudancas; nao introduza um novo framework de testes sem necessidade e autorizacao."
---

# Testes

Proteja comportamento observavel com testes estaveis e proporcionais ao risco.

## Abordagem

1. Identifique o comportamento, contrato ou regressao que precisa ser provado e as instrucoes aplicaveis.
2. Localize testes semelhantes, framework, fixtures, convencoes e comandos ja usados pelo projeto.
3. Escolha o nivel mais baixo que ofereca confianca adequada: unidade, integracao, contrato, componente ou ponta a ponta.
4. Cubra o caminho principal e os limites relevantes, como entradas invalidas, erros, autorizacao, concorrencia ou compatibilidade. Nao multiplique casos sem ganho de confianca.
5. Prefira resultados observaveis a detalhes internos. Evite testes que apenas reimplementam o algoritmo, dependem de tempo real, ordem acidental ou dados globais mutaveis.
6. Execute primeiro o menor conjunto afetado e depois suites mais amplas quando o custo e o risco justificarem.

Ao corrigir uma regressao, confirme quando pratico que o teste falha pela causa esperada antes da correcao e passa depois dela.

## Limites e relato

- Nao atualize snapshots ou expectativas apenas para silenciar uma falha sem confirmar o novo comportamento.
- Nao instale ferramentas ou reestruture toda a suite para uma mudanca pequena.
- Diferencie falhas introduzidas, falhas preexistentes e limitacoes do ambiente.
- Informe testes criados ou alterados, comandos executados, resultados e cobertura de risco ainda ausente.
