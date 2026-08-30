---
name: implementation-plan
description: "Transforme uma solicitacao de software em um plano tecnico executavel, com escopo, componentes, riscos, testes e criterios de conclusao. Use quando o usuario pedir planejamento; nao implemente o plano por padrao."
---

# Plano de implementacao

Crie um plano baseado na implementacao real do projeto ativo, nao apenas no texto da solicitacao.

## Abordagem

1. Expresse o resultado esperado e os comportamentos que devem permanecer inalterados.
2. Leia as instrucoes do projeto e inspecione somente os entrypoints, simbolos, testes e configuracoes necessarios para localizar a mudanca.
3. Identifique componentes afetados, dependencias, compatibilidade, migracoes e riscos operacionais ou de dados.
4. Escolha a menor estrategia coerente com os padroes existentes. Registre alternativas apenas quando houver uma decisao real a tomar.
5. Defina validacoes direcionadas, verificacoes mais amplas quando justificadas e criterios observaveis de conclusao.

Se uma incerteza impedir uma decisao segura, destaque-a e indique a menor verificacao ou resposta necessaria. Nao preencha lacunas com arquitetura inventada.

## Formato do plano

Adapte o detalhe a complexidade. Inclua:

- objetivo e fora de escopo;
- arquivos, modulos ou contratos afetados;
- passos de implementacao em ordem de dependencia;
- estrategia de testes e validacao;
- riscos, compatibilidade e eventual estrategia de reversao;
- criterios de conclusao.

Para mudancas pequenas, poucos passos concretos sao suficientes. Por padrao, nao edite codigo nem crie um arquivo de plano sem solicitacao explicita.
