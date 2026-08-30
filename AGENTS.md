# Instrucoes deste workspace

## Proposito e escopo

- Este repositorio e a camada generica de governanca e ferramentas do Codex. Codigo, arquitetura, regras de negocio, comandos e documentacao especificos pertencem ao repositorio correspondente em `projects/`.
- Trate cada diretorio imediato de `projects/` como um projeto independente, possivelmente com seu proprio repositorio Git.
- Mantenha instrucoes gerais aqui e workflows reutilizaveis em `.agents/skills/`. Nao promova particularidades de um projeto para o workspace.

## Projeto ativo e isolamento

- Antes de ler ou alterar algo em `projects/`, determine o projeto ativo pelo nome ou caminho fornecido pelo usuario, ou por uma dependencia inequivoca da solicitacao.
- Se o projeto nao puder ser determinado com seguranca, solicite o caminho exato. Nao enumere nem percorra os projetos para tentar adivinhar.
- Inspecione, modifique e execute comandos somente no projeto ativo e neste workspace quando a tarefa exigir. Nao leia projetos irmaos, compare implementacoes ou reutilize codigo entre projetos sem autorizacao explicita.
- Quando mais de um projeto for explicitamente colocado em escopo, mantenha evidencias, comandos e conclusoes separados por projeto.
- Antes de inspecionar codigo do projeto ativo, leia as instrucoes aplicaveis dentro dele. Para cada diretorio relevante, prefira `AGENTS.override.md` a `AGENTS.md`, use no maximo um desses arquivos por nivel e considere a instrucao mais proxima do arquivo-alvo como a mais especifica.
- Uma sessao iniciada na raiz deste workspace nao descobre automaticamente instrucoes abaixo do diretorio atual. Por isso, localize os arquivos de instrucao somente dentro do projeto ativo e leia os que se aplicam antes de trabalhar.

## Carregamento progressivo de contexto

- Trate o catalogo de skills disponivel na sessao — nome, descricao e caminho — como o indice de skills. Nao percorra `.agents/skills/` nem leia todos os `SKILL.md` para decidir qual usar.
- Selecione pela descricao somente a skill ou a menor combinacao de skills necessaria e entao leia por completo os respectivos `SKILL.md`. Leia `references/`, `scripts/` ou outros recursos de uma skill somente quando o `SKILL.md` selecionado indicar sua relevancia para a tarefa.
- Nunca carregue documentacao de projetos inativos. No projeto ativo, nao leia recursivamente `docs/` nem todos os arquivos Markdown para formar contexto inicial, salvo quando o usuario pedir explicitamente um inventario ou auditoria documental completa.
- Quando a tarefa depender de documentacao, consulte primeiro um unico indice leve indicado pelas instrucoes do projeto, preferencialmente `README-CODEX.md`, `docs/README.md` ou `docs/index.md`. Use o indice apenas para escolher os poucos documentos relacionados a pergunta.
- Se nao existir indice, liste nomes de arquivos ou busque titulos e termos relevantes somente dentro do projeto ativo; abra o menor conjunto de documentos capaz de responder a solicitacao e amplie uma lacuna por vez.
- Trate documentacao como guia, nao como prova final. Confirme no codigo, configuracao ou testes as afirmacoes que afetarem uma analise ou mudanca.

## Forma de trabalhar

- Aplique profundidade proporcional a tarefa. Em tarefas simples, avance sem criar cerimonia desnecessaria.
- Entenda a solicitacao e a implementacao existente antes de editar. Comece por manifestos, entrypoints, simbolos e testes diretamente relacionados; amplie a leitura apenas quando as evidencias exigirem.
- Preserve alteracoes locais existentes e nao toque em arquivos sem relacao com a solicitacao.
- Prefira mudancas pequenas, coerentes com a arquitetura e o estilo existentes. Nao adicione dependencias, abstracoes ou refatoracoes especulativas.
- Depois de editar, execute primeiro a validacao mais proxima da mudanca e depois verificacoes mais amplas quando o custo e o risco justificarem. Use build, testes, lint, formatacao, analise estatica e verificacao de tipos ja adotados pelo projeto.
- Revise o proprio diff antes de concluir. Relate o que mudou, as validacoes realmente executadas e qualquer limitacao ou risco residual; nunca declare uma verificacao que nao ocorreu.

## Revisao, documentacao e seguranca

- Em revisoes, priorize bugs, regressoes, seguranca, concorrencia, compatibilidade, tratamento de erros e testes ausentes. Revisar nao autoriza modificar o codigo.
- Mantenha documentacao especifica junto do projeto ativo e baseie-a apenas em codigo, configuracao ou informacao fornecida e verificada. Nao invente decisoes arquiteturais.
- Nao exponha secrets em arquivos, comandos, logs ou respostas.
- Antes de operacoes de alto impacto ou intencao ambigua — exclusao em massa, migracao destrutiva, infraestrutura, secrets, CI/CD, publicacao, deploy ou force push — pare e solicite autorizacao.
- Nunca descarte trabalho, reescreva historico ou execute operacoes Git destrutivas sem pedido explicito.
