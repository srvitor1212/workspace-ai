---
name: feature-plan-implementation
description: Implementa uma funcionalidade a partir de seu plano de implementação e atualiza o progresso real no plano. Use para alterar código já planejado; não crie nem revise requisitos, exceto ao consultar uma lacuna indispensável.
metadata:
  short-description: Implementa uma funcionalidade conforme o plano
---

# Objetivo

Implemente a funcionalidade conforme o plano localizado em
`projects/<nome-do-projeto-alvo>/docs/feature-implementation-plans` e mantenha
o documento como registro fiel do progresso, das validações e do estado da
implementação.

## Fonte de verdade e limites

- O plano de implementação é a fonte primária para escopo, ordem, decisões
  técnicas, arquivos e validações. Execute apenas os passos solicitados pelo
  usuário ou os passos ainda pendentes do plano escolhido.
- Não leia o documento correspondente em `docs/features` como rotina, para
  contexto adicional ou para repetir o levantamento. Consulte-o somente se uma
  decisão indispensável para executar um passo estiver ausente ou ambígua no
  plano e não puder ser resolvida pelo código, pelas convenções do projeto ou
  pela documentação técnica relevante.
- Se essa consulta ainda não resolver a decisão, interrompa antes de alterar o
  comportamento afetado e apresente a dúvida ao usuário. Não invente requisito
  nem modifique silenciosamente o plano para acomodar uma interpretação.
- Leia e respeite o `AGENTS.md` da raiz e o `AGENTS.md` e `README.md` do
  projeto-alvo antes de alterar código. Preserve alterações preexistentes e não
  faça mudanças fora dos arquivos necessários ao plano.
- Não crie commits, branches, pull requests, publicações, migrações de produção
  ou ações externas sem solicitação explícita.

## Fluxo de execução

1. **Localize e confira o plano.** Identifique o projeto-alvo e o arquivo de
   plano indicado. Leia o bloco de estado, a ordem de implementação, os arquivos
   afetados, as decisões, a estratégia de validação, os riscos e o histórico.
   Confirme quais passos ainda estão desmarcados e suas dependências.

2. **Verifique a base atual.** Inspecione os arquivos mencionados e seus
   equivalentes necessários para entender as convenções e identificar mudanças
   já realizadas. Se trabalho preexistente corresponder a um passo, não o
   sobrescreva: valide-o contra o plano antes de decidir se ele pode ser marcado
   como concluído.

3. **Atualize o início do trabalho.** Antes da primeira alteração de código,
   atualize o plano para `Implementação iniciada`, atualize `Última atualização
   (UTC)` e acrescente uma linha ao histórico indicando que a execução começou.
   Preserve o cabeçalho e as entradas anteriores.

4. **Implemente na ordem definida.** Execute os passos respeitando as
   dependências. Siga as decisões e os trechos decisivos do plano; adapte apenas
   detalhes de baixo risco exigidos pela base de código. Para uma adaptação que
   mude contrato, comportamento, segurança, dados, integração, migração ou
   validação, pare e trate-a como uma decisão pendente.

5. **Valide cada passo.** Execute os testes, verificações estáticas, builds ou
   cenários manuais previstos e proporcionais à mudança, preferindo os comandos
   e padrões já presentes no projeto. Registre falhas relevantes e não apresente
   uma validação não executada como aprovada.

6. **Atualize o plano com o progresso real.** Assim que um passo estiver
   integralmente implementado e sua verificação prevista tiver resultado
   satisfatório, altere somente o checklist daquele passo para
   `- [x] Implementado`. Atualize a data em UTC e o histórico, identificando os
   passos concluídos e as validações executadas. Mantenha em `[ ]` qualquer passo
   parcial, bloqueado, não iniciado ou cuja verificação ainda falhe. Se o plano
   não tiver espaço para o resultado essencial da validação, acrescente-o à seção
   `## Estratégia de testes e validação`, sem remover o planejamento original.

7. **Conclua com precisão.** Use `Implementação completa` somente quando todos
   os passos aplicáveis estiverem marcados, as validações previstas tiverem sido
   executadas com êxito ou tiverem resultado explicitamente registrado, e não
   houver decisão ou bloqueio pendente. Caso contrário, mantenha
   `Implementação iniciada` e registre no histórico os passos pendentes,
   bloqueios e falhas de validação.

## Regras para atualizar o plano

Mantenha no topo, sem duplicar, estas linhas:

```markdown
> **Estado da implementação:** Plano criado | Implementação iniciada | Implementação completa
> **Última atualização (UTC):** YYYY-MM-DD HH:mm:ss UTC
```

Atualize o histórico sem apagar linhas anteriores:

```markdown
| Data e hora (UTC) | Alteração |
| --- | --- |
| YYYY-MM-DD HH:mm:ss UTC | Implementação iniciada. |
| YYYY-MM-DD HH:mm:ss UTC | Passos 1 e 2 concluídos; validações: <resumo>. |
| YYYY-MM-DD HH:mm:ss UTC | Implementação completa; validações: <resumo>. |
```

Não marque um passo como concluído somente por haver alteração de código. O
checklist representa a conclusão integral do passo e sua verificação. Não
remova passos, decisões, requisitos mapeados ou validações do plano para fazê-lo
parecer completo. Se o plano precisar mudar materialmente, registre o impacto e
solicite a atualização do planejamento ou dos requisitos antes de prosseguir.

## Revisão antes da entrega

Confirme que:

- todas as alterações estão previstas no plano ou são detalhes compatíveis com
  suas decisões;
- os testes e verificações executados, incluindo falhas, estão relatados com
  precisão;
- o checklist, o estado, a data UTC e o histórico refletem o progresso real;
- os passos pendentes ou bloqueados permanecem explícitos; e
- nenhuma alteração não relacionada ou dado sensível foi introduzido.

## Entrega

Informe os arquivos alterados, os passos concluídos e pendentes, o estado final
do plano, as validações executadas e quaisquer bloqueios. Se foi necessário ler
o documento em `docs/features`, informe qual lacuna indispensável justificou a
consulta.
