---
name: repository-analysis
description: "Analise um repositorio existente para mapear estrutura, entrypoints, dependencias, componentes e fluxos. Use para compreender arquitetura ou localizar codigo; nao use para implementar mudancas nem para revisar um diff especifico."
---

# Analise de repositorio

Produza uma explicacao verificavel do projeto ativo sem modificar seus arquivos.

## Abordagem

1. Defina a pergunta que a analise precisa responder e confirme o limite do projeto ativo.
2. Leia as instrucoes aplicaveis e observe o estado do Git sem alterar nada.
3. Comece por sinais de alto valor: arvore de primeiro nivel, manifestos, configuracoes, entrypoints, testes relacionados e nomes de simbolos ligados a pergunta.
4. Se a pergunta depender de documentacao, use primeiro o indice leve declarado pelo projeto, como `README-CODEX.md` ou `docs/index.md`, e abra somente os documentos indicados para o tema. Sem indice, busque nomes, titulos ou termos antes de abrir arquivos.
5. Use busca direcionada para seguir imports, chamadas, dados e limites entre componentes. Amplie a leitura somente quando uma lacuna concreta exigir.
6. Confirme padroes arquiteturais em mais de uma evidencia antes de nomea-los. Diferencie fatos observados, inferencias e pontos ainda desconhecidos.

Nao abra toda a arvore documental para obter contexto geral, exceto em uma auditoria documental explicitamente solicitada. Nao execute builds ou suites caras apenas para conhecer a estrutura. Use comandos somente quando responderem a pergunta ou validarem uma conclusao relevante.

## Resultado esperado

Entregue, na profundidade proporcional a solicitacao:

- objetivo e escopo analisado;
- componentes e entrypoints relevantes, com caminhos;
- fluxo principal ou relacoes entre modulos;
- dependencias e integracoes que afetam a pergunta;
- convencoes arquiteturais sustentadas por evidencias;
- riscos, lacunas e perguntas em aberto.

Evite despejar uma arvore completa ou resumir arquivos sem explicar sua relevancia.
