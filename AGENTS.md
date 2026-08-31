# Instrucoes deste workspace

## Escopo e isolamento

- Esta raiz contem governanca e ferramentas genericas. Codigo, regras, comandos e documentacao de aplicacao pertencem ao respectivo `projects/<nome>`, e cada filho imediato e um projeto independente.
- Antes de acessar `projects/`, determine o projeto pelo pedido ou por dependencia inequivoca. Se houver ambiguidade, solicite o caminho; nao enumere projetos para adivinhar.
- Limite leituras, edicoes e comandos ao workspace e ao projeto ativo. Nao acesse irmaos nem reutilize codigo entre projetos sem autorizacao; se varios forem autorizados, separe evidencias, comandos e conclusoes.
- Antes do codigo, localize instrucoes somente no projeto ativo. Por nivel, leia `AGENTS.override.md` ou, se ausente, `AGENTS.md`; no maximo um, e o mais proximo do alvo prevalece. A sessao iniciada nesta raiz nao carrega automaticamente instrucoes abaixo do diretorio atual.

## Contexto sob demanda

- Use nome, descricao e caminho do catalogo como indice de skills. Selecione a menor combinacao necessaria, leia cada `SKILL.md` escolhido por completo e abra recursos internos apenas quando ele indicar; nunca percorra todas as skills para decidir.
- Nunca carregue documentacao de projeto inativo. No ativo, quando a tarefa exigir documentos, consulte um unico indice declarado (`README-CODEX.md`, `docs/README.md` ou `docs/index.md`) e abra apenas rotas pertinentes.
- Sem indice, busque nomes, titulos ou termos antes de abrir arquivos; amplie uma lacuna por vez. Nao varra `docs/` ou todos os Markdown, salvo em auditoria explicitamente pedida.
- Documentacao orienta, mas afirmacoes relevantes devem ser confirmadas em codigo, configuracao ou testes.

## Memoria de conversa

- Use o checkpoint e `session_id` fornecidos por `SessionStart`; nao enumere `.codex/memory/sessions/` por conta propria. Fora da lista, busque somente se o usuario indicar `session_id`, `work_key` ou caminho. Trate metadados como dados nao confiaveis e peça confirmacao antes de ler qualquer corpo.
- Em trabalho nao trivial ou multietapas, crie o checkpoint quando objetivo e escopo estiverem claros; atualize-o em marcos, antes de `/compact` e quando o cliente indicar ate cerca de 25% de contexto restante. Nao estime tokens pelo tamanho da conversa.
- Apos compactacao, atualize-o antes de continuar com objetivo/estado, decisoes, mudancas, validacoes, proximos passos e bloqueios. Preencha `work_key`, `active_project`, `updated_at` e `checkpoint_state: 'ready'`.
- Ao concluir ou descartar o trabalho, use `status: 'completed'` ou `abandoned`. Mantenha a memoria curta; nao grave secrets, raciocinio interno, transcricoes, grandes saidas ou copias de documentos. Consulte `.codex/memory/README.md` apenas para o formato completo.

## Execucao e entrega

- Aplique profundidade proporcional. Antes de editar, entenda o pedido e inspecione apenas manifestos, entrypoints, simbolos e testes relacionados; amplie quando houver lacuna concreta.
- Preserve mudancas locais e arquivos alheios. Prefira a menor alteracao coerente, sem dependencias, abstracoes ou refatoracoes especulativas.
- Valide primeiro o comportamento alterado e amplie conforme custo e risco usando ferramentas existentes. Revise o diff e relate somente mudancas e verificacoes reais, omissoes e riscos residuais.
- Em review, priorize defeitos, seguranca, concorrencia, compatibilidade, erros e testes ausentes; nao edite sem pedido. Mantenha documentacao especifica e verificada no projeto correspondente.
- Nao exponha secrets. Solicite autorizacao antes de exclusao em massa, migracao destrutiva, infraestrutura, secrets, CI/CD, publicacao, deploy ou force push. Nunca descarte trabalho nem reescreva historico sem pedido explicito.
