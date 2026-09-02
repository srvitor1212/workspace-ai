---
name: feature-discovery
description: Conduz uma entrevista curta para entender e mapear uma nova funcionalidade antes da implementação, considerando o contexto do repositório, tecnologias, dados e integrações.
metadata:
  short-description: Entrevista antes de planejar funcionalidades
---

# Feature Discovery

Ajude o usuário a transformar uma ideia de funcionalidade em um objetivo claro e tecnicamente mapeado. Esta skill serve para descoberta e análise; não implemente a funcionalidade durante este fluxo.

## Quando usar

Use quando o usuário pedir uma nova funcionalidade, recurso, módulo, tela, integração ou mudança relevante de comportamento. Também use quando ele disser algo como “vamos criar uma nova funcionalidade”.

## Preparação

1. Identifique o repositório de trabalho e confirme o escopo.
2. Leia o `AGENTS.md` e o `README.md` mais próximos.
3. Consulte apenas a documentação e os arquivos de configuração relevantes em `docs/`.
4. Determine se a ideia altera um sistema existente ou inicia um projeto novo.
5. Observe tecnologias, banco de dados, integrações, padrões e limitações já existentes. Não invente informações ausentes.

Não altere código, configuração ou documentação durante a entrevista.

## Entrevista em etapas

Faça de 3 a 5 perguntas por rodada e aguarde as respostas. Comece pelas perguntas mais importantes para o objetivo atual. Adapte as perguntas ao que já existe no repositório.

Depois da primeira resposta, faça mais 2 ou 3 perguntas de aprofundamento, somente sobre lacunas relevantes. Evite repetir perguntas já respondidas e não transforme a entrevista em um questionário genérico.

Procure fazer no máximo 3 rodadas de perguntas, porém, se ainda estiver muito vago pergunte ao usuário se pode ter mais rodadas de perguntas para melhor entendimento.

Quando o projeto for novo, pergunte o suficiente para definir o problema, usuários, plataforma, tecnologias preferidas, persistência e integrações necessárias. Quando o projeto já existir, priorize impacto no comportamento atual, compatibilidade, dados, APIs, telas, permissões e testes.

## Fechamento

Quando houver informação suficiente:

1. Apresente um resumo curto do entendimento.
2. Mostre o caminho e o título do arquivo de análise que pretende criar.
3. Mostre o conteúdo resumido ou os tópicos principais.
4. Peça confirmação explícita antes de criar o arquivo.

Se o usuário não confirmar, ajuste o entendimento e continue a conversa sem salvar nada.

## Arquivo de análise

Após confirmação explícita, crie a pasta `analyses/` dentro do repositório de trabalho e salve um Markdown com o formato:

`YYYY-MM-DD - HH-mm-ss - titulo-da-tarefa.md`

Use o horário local disponível e um título curto, legível e seguro para o nome do arquivo. Para um repositório que ainda não existe, use `projects/tmp/analyses/`.

Mantenha o documento objetivo e enxuto, com estas seções:

```markdown
# Título da tarefa

## Objetivo

## Contexto atual

## Requisitos

## Decisões técnicas

## Escopo afetado

## Riscos e dúvidas

## Critérios de aceitação

## Próximos passos
```

Registre fatos confirmados, decisões tomadas e pontos pendentes. Marque como pendente qualquer informação que não tenha sido confirmada. Depois de salvar, informe o caminho do arquivo. A implementação só deve começar em uma solicitação posterior ou quando o usuário pedir explicitamente.
