# Índice de contexto do projeto para Codex

Este é o mapa leve de contexto e documentação deste projeto. Mantenha aqui somente informações específicas e verificadas, com links para as fontes detalhadas em vez de copiar seu conteúdo.

## Como usar este índice

- Consulte este arquivo quando a tarefa precisar de orientação sobre arquitetura, operação ou documentação.
- Abra somente os documentos indicados para o tema da tarefa.
- Não percorra toda a documentação como preparação padrão.
- Se uma informação do índice afetar uma mudança, confirme-a no código, configuração ou testes.

## Visão geral

<!-- Explique o propósito, os usuários do sistema e os limites do projeto. -->

## Como começar

### Pré-requisitos

<!-- Ferramentas, versões, serviços e acesso necessários. -->

### Preparação

```text
<comandos verificados para preparar o ambiente>
```

### Execução local

```text
<comando verificado e diretório de execução>
```

## Validação

| Objetivo | Comando verificado | Observações |
| --- | --- | --- |
| Build | `<comando>` | `<pré-requisitos ou não aplicável>` |
| Teste direcionado | `<comando>` | `<como selecionar módulo ou caso>` |
| Teste completo | `<comando>` | `<custo ou dependências>` |
| Qualidade | `<comando>` | `<lint, tipos, formatação ou análise estática>` |

## Mapa técnico

- Entrypoints: <!-- caminhos -->
- Módulos principais: <!-- caminhos e responsabilidade -->
- Persistência e integrações: <!-- componentes verificados -->

## Índice de documentação

Mantenha uma linha por tema. O campo "Quando consultar" deve permitir decidir se o documento é relevante antes de abri-lo.

| Tema | Caminho | Quando consultar | Fonte de verdade |
| --- | --- | --- | --- |
| `<tema>` | [`<documento>`](<caminho-relativo>) | `<tipo de tarefa ou dúvida>` | `<código, contrato, configuração ou documento>` |

Não liste arquivos temporários, gerados ou sem utilidade para decisões. Se o projeto já adota outro índice, aponte para ele aqui em vez de manter dois catálogos.

## Restrições conhecidas

<!-- Compatibilidade, áreas legadas, dados sensíveis e operações que exigem cuidado. -->

## Manutenção deste documento

Atualize este índice quando comandos, estrutura, restrições ou caminhos documentais mudarem. Se uma informação não puder ser confirmada no código ou no ambiente, marque-a como pendente em vez de apresentá-la como fato.
