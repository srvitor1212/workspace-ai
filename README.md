# Workspace central para OpenAI Codex

Este repositório é uma camada genérica de governança, contexto e workflows para usar o Codex em desenvolvimento de software. Ele organiza a forma de analisar, planejar, implementar, depurar, testar, revisar e documentar projetos sem incorporar regras de nenhuma aplicação específica.

Os repositórios reais ficam em `projects/`, permanecem independentes e são ignorados pelo Git deste workspace.

## Arquitetura

```text
workspace-ai/
├── AGENTS.md
├── README.md
├── .gitignore
├── .agents/
│   └── skills/
│       ├── repository-analysis/
│       │   └── SKILL.md
│       ├── implementation-plan/
│       │   └── SKILL.md
│       ├── implement-change/
│       │   └── SKILL.md
│       ├── debugging/
│       │   └── SKILL.md
│       ├── code-review/
│       │   └── SKILL.md
│       ├── testing/
│       │   └── SKILL.md
│       └── documentation/
│           └── SKILL.md
├── templates/
│   └── project/
│       ├── AGENTS.md
│       └── README-CODEX.md
├── scripts/
│   └── Test-Workspace.ps1
└── projects/                 # conteúdo ignorado por este Git
```

As responsabilidades são separadas deliberadamente:

- `AGENTS.md` define como o Codex deve se comportar neste workspace.
- `.agents/skills/` descreve como executar categorias específicas de tarefa.
- `templates/project/` ajuda cada projeto a manter seu próprio contexto.
- `scripts/` contém somente automação determinística útil ao workspace.
- `projects/` contém repositórios independentes e nunca é fonte de regras globais.

## Início rápido

1. Na raiz do workspace, crie `projects/` se a pasta ainda não existir:

   ```powershell
   New-Item -ItemType Directory -Force .\projects | Out-Null
   ```

2. Clone ou mova um repositório para um caminho próprio:

   ```powershell
   git clone <url-do-repositorio> .\projects\MeuProjeto
   ```

3. Inicie o Codex na raiz deste workspace:

   ```powershell
   codex
   ```

   De outro diretório, use `codex --cd C:\caminho\para\workspace-ai`. Se a política de execução do Windows bloquear o wrapper `codex.ps1` de uma instalação npm, invoque `codex.cmd` sem alterar a política do sistema.

4. Informe sempre o projeto no prompt:

   ```text
   Analise a arquitetura do projeto projects/MeuProjeto.
   ```

O modo recomendado é manter a sessão na raiz e selecionar o projeto pelo caminho no prompt. Isso carrega a governança e as skills do workspace e evita que um projeto vizinho entre no contexto por acidente.

## Como adicionar ou preparar um projeto

Cada filho imediato de `projects/` pode ser um repositório Git completo, com branch, histórico, configuração, documentação e instruções próprias. O Git externo não rastreia nem interfere nesses arquivos porque `/projects/` está ignorado.

Para preparar um projeto novo:

1. Adicione o repositório em `projects/<nome>`.
2. Verifique se ele já possui `AGENTS.md`, `AGENTS.override.md` ou documentação equivalente.
3. Se precisar de instruções próprias, adapte `templates/project/AGENTS.md` dentro do projeto. Não sobrescreva um arquivo existente; mescle apenas o que for compatível.
4. Use `templates/project/README-CODEX.md` como checklist para comandos, entrypoints e restrições verificadas.
5. Mantenha todas as informações da aplicação dentro do repositório da aplicação.

Não é necessário cadastrar projetos em um índice central. O caminho explícito no prompt é o seletor de escopo e reduz o risco de contexto cruzado.

## Isolamento entre projetos

Por padrão, o Codex deve trabalhar em um único projeto ativo. O `AGENTS.md` da raiz determina que ele:

- não liste ou percorra `projects/` para adivinhar o alvo;
- não leia projetos irmãos;
- não compare padrões entre aplicações;
- não copie implementações entre projetos;
- separe evidências e comandos quando vários projetos forem explicitamente autorizados.

Se o prompt não identificar o projeto com segurança, o Codex deve pedir o caminho em vez de explorar todos os diretórios.

## Resolução de instruções

O Codex monta a cadeia de instruções uma vez no início de cada execução ou sessão:

1. No escopo global (`CODEX_HOME`, normalmente `~/.codex`), usa `AGENTS.override.md` quando existe; caso contrário, usa `AGENTS.md`. Apenas o primeiro arquivo não vazio desse nível entra na cadeia.
2. No escopo do projeto, parte do project root — normalmente o Git root — e segue até o diretório de trabalho atual.
3. Em cada diretório, procura nesta ordem: `AGENTS.override.md`, `AGENTS.md` e nomes configurados em `project_doc_fallback_filenames`. No máximo um arquivo por diretório é carregado.
4. Os arquivos são concatenados da raiz para o diretório atual. Instruções mais próximas aparecem depois e especializam ou substituem orientações anteriores em caso de conflito.
5. Arquivos vazios são ignorados. O limite combinado padrão é 32 KiB, configurável por `project_doc_max_bytes`.

No mesmo diretório, `AGENTS.override.md` substitui `AGENTS.md`; os dois não são combinados. Mudanças nas instruções exigem uma nova sessão para reconstruir a cadeia.

### Repositórios Git aninhados em `projects/`

Este layout cria uma fronteira que precisa ser entendida:

- Ao iniciar na raiz do workspace, o Codex descobre automaticamente o `AGENTS.md` e as skills deste repositório. Arquivos de instrução abaixo do diretório atual não entram automaticamente na cadeia inicial. Por isso, a governança da raiz manda localizar e ler, apenas no projeto ativo, os `AGENTS.md` ou `AGENTS.override.md` aplicáveis antes de analisar código.
- Ao iniciar diretamente dentro de `projects/MeuProjeto`, o repositório Git interno tende a se tornar o project root. Nesse modo, o `AGENTS.md` e `.agents/skills/` do workspace externo ficam fora da busca ascendente e não devem ser considerados carregados.

Consequentemente, use a raiz do workspace para o modo governado e multi-repositório. Inicie dentro do repositório interno somente quando quiser deliberadamente uma sessão isolada do projeto. Se a governança genérica também precisar valer nesse segundo modo, mova uma versão adequada das regras para o escopo global do usuário; não duplique silenciosamente arquivos entre repositórios.

Para diagnosticar carregamento, inicie uma nova execução e peça:

```text
Liste as fontes de instrução carregadas e resuma o escopo de cada uma.
```

A documentação oficial também sugere verificar o workspace root reportado pelo cliente quando as instruções esperadas não aparecem.

## Agent Skills

O Codex descobre skills locais em `.agents/skills` do diretório atual até o repository root. Inicialmente, somente `name`, `description` e caminho participam da descoberta; o conteúdo completo de `SKILL.md` é carregado quando a skill é selecionada. Isso mantém baixo o custo de contexto.

Uma skill pode ser ativada implicitamente pela descrição ou explicitamente com `$nome`:

```text
$repository-analysis mapeie o fluxo de autenticação em projects/AuthServiceApi.
```

| Skill | Responsabilidade | Modifica por padrão? |
| --- | --- | --- |
| `repository-analysis` | Mapear estrutura, entrypoints, dependências e fluxos | Não |
| `implementation-plan` | Transformar um pedido em plano técnico verificável | Não |
| `implement-change` | Implementar e validar uma mudança já entendida | Sim |
| `debugging` | Reproduzir, reunir evidências e localizar causa raiz | Não; somente se a correção for pedida |
| `code-review` | Encontrar defeitos e riscos em mudanças | Não |
| `testing` | Analisar, criar, ajustar ou executar testes | Conforme o pedido |
| `documentation` | Atualizar documentação verificada no projeto | Conforme o pedido |

As skills atuais são autocontidas. Diretórios opcionais como `references/`, `scripts/`, `assets/` e `agents/openai.yaml` devem ser adicionados somente quando houver conteúdo condicional, automação determinística, artefatos de saída ou metadados de interface que tragam valor real.

### Criar uma nova skill

1. Confirme que a capacidade é reutilizável e não pertence a um único projeto.
2. Use `$skill-creator` ou crie `.agents/skills/<nome>/SKILL.md`.
3. Use nome em minúsculas com hífens e frontmatter com `name` e `description` discriminante.
4. Mantenha o workflow principal curto. Mova detalhes condicionais para `references/` e lógica repetitiva para `scripts/`.
5. Valide a estrutura e teste prompts que devem e não devem acionar a skill.

Estrutura mínima:

```markdown
---
name: nome-da-skill
description: Explique o que faz, quando usar e um limite que evite acionamento incorreto.
---

# Instruções

Descreva o resultado, as decisões importantes e as restrições reais.
```

## Exemplos de uso

```text
Analise a arquitetura do projeto projects/AuthServiceApi.
```

```text
Investigue o erro de autenticação no projeto projects/AuthServiceApi. Não altere código até apresentar a causa provável e as evidências.
```

```text
Revise as alterações atuais do projeto projects/AuthServiceApi.
```

```text
Crie um plano para implementar refresh tokens no projeto projects/AuthServiceApi.
```

```text
Implemente a validação descrita no issue no projeto projects/AuthServiceApi e execute os testes relacionados.
```

Para tarefas maiores, informe resultado esperado, contexto relevante, limites e critérios de conclusão. Para tarefas pequenas, um objetivo e o caminho do projeto normalmente bastam.

## Validação do workspace

O script não instala dependências nem acessa os projetos. Ele verifica arquivos obrigatórios, nomes e frontmatter das skills, duplicidades e a regra de ignore de `projects/`.

Windows PowerShell 5.1:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Test-Workspace.ps1
```

PowerShell 7+:

```powershell
pwsh -NoProfile -File .\scripts\Test-Workspace.ps1
```

O uso de `Bypass` vale somente para esse processo e não altera a política de execução do sistema.

## Configuração e extensões avaliadas

O workspace usa somente recursos nativos necessários: instruções hierárquicas, skills locais, templates e um validador PowerShell.

Não há `.codex/config.toml` compartilhado. Configurações de modelo, personalidade, approvals, sandbox, busca web e perfis dependem do usuário e do ambiente; além disso, camadas `.codex/` de projeto só são carregadas quando o projeto é confiável. Se no futuro houver uma política comum e revisada, ela pode ser adicionada separadamente.

Outras extensões atuais — plugins, MCP, hooks, Record & Replay, subagentes e metadados `agents/openai.yaml` — continuam disponíveis, mas não resolvem uma necessidade deste núcleo. Adote-as quando surgir integração externa, evento determinístico, workflow demonstrável ou interface distribuível, mantendo permissões e dependências explícitas.

## Boas práticas

- Nomeie o projeto e o resultado desejado no prompt.
- Mantenha comandos e convenções específicos no `AGENTS.md` do próprio projeto.
- Prefira busca direcionada a leitura recursiva ampla.
- Preserve mudanças locais e revise o diff antes de concluir.
- Execute validações existentes, começando pelas mais próximas da mudança.
- Informe claramente o que não pôde ser validado.
- Consulte documentação oficial quando o comportamento de uma ferramenta ou API puder ter mudado.
- Reavalie regras e skills com exemplos reais; remova instruções que apenas repetem o comportamento padrão do Codex.

## Limitações conhecidas

- A cadeia automática de `AGENTS.md` é definida no início da sessão e não atravessa de forma garantida o Git root de um repositório aninhado.
- Instruções do projeto ativo são lidas explicitamente no modo raiz; isso é uma convenção de governança deste workspace, não uma segunda cadeia automática do cliente.
- Como `projects/` é totalmente ignorada, clones novos precisam criar a pasta antes de adicionar o primeiro projeto.
- `Test-Workspace.ps1` valida estrutura e metadados básicos, não a qualidade semântica de uma skill.
- Recursos do Codex evoluem. Revise periodicamente os links oficiais e valide mudanças em uma sessão nova.

## Fontes oficiais

Estrutura e decisões conferidas na documentação oficial atual e em exemplos mantidos pela OpenAI:

- [Custom instructions with AGENTS.md](https://developers.openai.com/codex/guides/agents-md)
- [Build skills](https://developers.openai.com/codex/skills)
- [Config basics](https://developers.openai.com/codex/config-basic)
- [Prompting](https://developers.openai.com/codex/prompting)
- [Catálogo oficial openai/skills](https://github.com/openai/skills)

As escolhas principais foram manter o `AGENTS.md` enxuto, deixar workflows nas skills, usar descrições discriminantes para ativação, evitar diretórios opcionais vazios e não versionar configurações operacionais sem uma necessidade concreta.
