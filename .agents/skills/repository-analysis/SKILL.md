---
name: repository-analysis
description: "Mapeie estrutura, entrypoints, dependencias e fluxos sem modificar arquivos. Use para compreender ou localizar codigo; nao use para revisar diffs."
---

# Analise de repositorio

Explique o projeto ativo com evidencias, sem modifica-lo.

## Processo

1. Defina a pergunta e o limite do projeto; leia instrucoes aplicaveis e o estado do Git.
2. Comece por arvore de primeiro nivel, manifestos, configuracoes, entrypoints, testes e simbolos ligados a pergunta.
3. Se precisar de documentos, use o indice leve do projeto e abra apenas as rotas pertinentes; sem indice, busque nomes, titulos ou termos.
4. Siga imports, chamadas, dados e fronteiras por busca direcionada, ampliando somente para sanar lacunas.
5. Sustente padroes arquiteturais com mais de uma evidencia e diferencie fatos, inferencias e desconhecidos.

Nao varra toda a documentacao, salvo em auditoria explicita, nem execute builds caros apenas para conhecer a estrutura.

## Entrega

Relate escopo, componentes e entrypoints relevantes, fluxo, dependencias, convencoes comprovadas, riscos e lacunas. Cite caminhos e explique a relevancia; evite despejar a arvore ou resumir arquivos indiscriminadamente.
