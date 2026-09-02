---
name: implementation-plan
description: Cria um plano de implementação testável a partir de uma análise confirmada em analyses/, dividindo a funcionalidade em etapas incrementais sem alterar código nem criar testes unitários.
metadata:
  short-description: Divide uma funcionalidade em etapas testáveis
---

# Implementation Plan

O unico arquivo que esta skill pode criar e o plano de implementacao, apos a confirmacao explicita do usuario. Nao altere arquivos existentes.

Crie somente um plano de implementação para uma funcionalidade já analisada. Esta skill não altera código, configuração ou documentação técnica do projeto e não cria testes unitários.

## Quando usar

Use quando o usuário pedir um plano de implementação, quiser transformar uma análise em etapas ou solicitar a implementação de uma funcionalidade por passos.

## Pré-requisito e preparação

1. Localize a análise em `analyses/` que está sendo discutida no chat.
2. Se houver mais de uma análise possível ou nenhuma referência clara, pergunte ao usuário qual arquivo deve ser usado. Nunca escolha por suposição.
3. Leia a análise completa e considere as decisões já tomadas no chat.
4. Leia o `AGENTS.md`, o `README.md` e apenas a documentação e os arquivos de configuração relevantes do repositório.
5. Inspecione o código necessário para confirmar tecnologias, padrões, pontos de integração, persistência e áreas afetadas.

Não comece a implementar nada durante essa preparação.

## Construção do plano

Divida o trabalho em quantas etapas forem necessárias para que cada etapa tenha valor e possa ser implementada e verificada isoladamente. Evite tanto etapas triviais sem valor quanto blocos grandes demais.

Organize as etapas de forma incremental, normalmente começando por uma estrutura mínima e evoluindo para integrações, persistência, regras e acabamento. Considere dependências entre etapas, mas deixe cada etapa executável e testável quando possível.

Cada etapa deve informar:

```markdown
### Etapa N — Título

- Objetivo:
- Arquivos ou áreas prováveis:
- Alterações previstas:
- Como validar:
- Resultado esperado:
```

Em `Como validar`, descreva verificações manuais, chamadas de API, execução local, validações existentes ou outros testes práticos apropriados. Não inclua a criação ou implementação de testes unitários; isso será tratado por outra skill.

O plano deve permitir que o usuário escolha implementar uma etapa ou várias etapas por vez. Não presuma que todas serão executadas em uma única tarefa.

## Confirmação antes de salvar

Antes de criar o arquivo:

1. Apresente um resumo do entendimento.
2. Mostre a quantidade e os títulos das etapas.
3. Informe o caminho do arquivo que será criado.
4. Peça confirmação explícita ao usuário.

Se o usuário não confirmar, ajuste o plano conforme solicitado e não salve o arquivo.

## Arquivo de saída

Crie o plano na mesma pasta `analyses/` da análise de origem. Derive o nome removendo o `.md` final e acrescentando ` - IMPLEMENTAÇÃO.md`.

Exemplo:

```text
2026-09-02 - 01-09-05 - controle-financeiro.md
2026-09-02 - 01-09-05 - controle-financeiro - IMPLEMENTAÇÃO.md
```

Se o arquivo de destino já existir, peça orientação antes de sobrescrever. Para uma análise em `projects/tmp/analyses/`, mantenha o plano nessa mesma pasta.

Use este formato enxuto:

```markdown
# Título da funcionalidade — Plano de implementação

Fonte: `nome-do-arquivo-de-analise.md`

## Objetivo

## Premissas

## Etapas

### Etapa 1 — Título

- Objetivo:
- Arquivos ou áreas prováveis:
- Alterações previstas:
- Como validar:
- Resultado esperado:

## Fora do escopo

- Testes unitários e sua implementação.

## Dependências e riscos

## Critério de conclusão
```

Registre fatos da análise e do repositório sem inventar detalhes. Marque decisões não confirmadas como pendentes. Depois de salvar, informe o caminho do arquivo e reforce que nenhum código foi alterado.
