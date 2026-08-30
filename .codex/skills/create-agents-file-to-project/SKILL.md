---
name: create-agents-file-to-project
description: Cria um arquivo AGENTS.md para um repositório de software que ainda não tenha esse arquivo. Use quando o Codex precisar inspecionar um projeto e documentar linguagem, versões de runtime ou framework, pacotes instalados, resumo da arquitetura, comandos de desenvolvimento e orientações específicas para agentes.
---

# Criar AGENTS.md Para Projeto

Crie um `AGENTS.md` conciso, útil e verificável para um único repositório alvo que ainda não tenha esse arquivo.

## Regras

- Trabalhe somente no repositório explicitamente solicitado pelo usuário. Se o usuário informar um nome lógico de projeto, resolva o caminho pela configuração local do workspace antes de editar.
- Se já existir um `AGENTS.md`, não sobrescreva o arquivo sem pedido explícito do usuário.
- Prefira fatos comprovados por arquivos do repositório em vez de inferências. Quando algo importante não puder ser confirmado, registre como "Não encontrado" ou "Confirmar com o usuário".
- Preserve mudanças existentes do usuário e arquivos não relacionados. Mantenha a edição final restrita ao `AGENTS.md`.
- Não instale dependências, não execute migrations, não suba serviços e não acesse sistemas externos apenas para descobrir informações do projeto.

## Descoberta Do Repositório

Inspecione primeiro o menor conjunto útil de arquivos:

- Contexto do projeto: `README*`, `docs/`, `.editorconfig`, `.gitignore`, arquivos de orientação para assistentes como `CLAUDE.md`, `.cursorrules`, `.github/copilot-instructions.md` ou `.windsurfrules`.
- Linguagem e versões: `.csproj`, `global.json`, `package.json`, `.nvmrc`, `pnpm-lock.yaml`, `yarn.lock`, `requirements.txt`, `pyproject.toml`, `Pipfile`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle*`, `Gemfile`, `composer.json`, `Dockerfile`, `docker-compose*.yml`, `.tool-versions`, `.sdkmanrc`.
- Pacotes e dependências: use manifests primeiro; use lockfiles apenas para confirmar gerenciadores de pacote ou versões exatas quando isso for relevante.
- Arquitetura: diretórios de topo, arquivos de solution/projeto, nomes de módulos, entrypoints, arquivos de configuração, diretórios de banco/infra, testes e arquivos de deploy.
- Comandos: scripts em manifests, `Makefile`, task runners, workflows de CI, launch settings, Docker Compose e instruções do README.

Use ferramentas rápidas de busca local, como `rg` e `rg --files`, quando disponíveis. Leia arquivos pontuais; evite despejos recursivos amplos.

## Formato Sugerido Do AGENTS.md

Use português quando o repositório ou o contexto do usuário estiver em português; caso contrário, use o idioma dominante do projeto. Mantenha o arquivo prático e fácil de escanear.

Estrutura recomendada:

```markdown
# <Nome Do Projeto>

## Visão Geral
- Propósito:
- Stack principal:
- Versões de runtime/framework:

## Arquitetura
- Pontos de entrada:
- Módulos principais:
- Dados/armazenamento:
- Integrações externas:

## Comandos De Desenvolvimento
- Instalar/restaurar:
- Build:
- Testes:
- Executar localmente:
- Lint/format:

## Pacotes E Dependências
- Gerenciador de pacotes:
- Dependências principais de produção:
- Dependências principais de desenvolvimento/teste:

## Convenções Do Repositório
- Estilo de código:
- Expectativas de teste:
- Configuração/segredos:
- Arquivos gerados:

## Orientações Para Agentes
- Trabalhe somente neste repositório.
- Prefira padrões, helpers e bibliotecas já existentes.
- Não altere módulos não relacionados ou artefatos gerados sem necessidade.
- Verifique mudanças com o comando mais específico e significativo disponível.
```

Adapte os títulos ao projeto. Remova seções que ficariam vazias, mas mantenha notas explícitas de "Não encontrado" para comandos, versões ou convenções importantes que não puderem ser confirmados.

## Verificações Finais

Antes de concluir:

- Confirme que o repositório alvo não tinha `AGENTS.md` antes da criação.
- Confirme que toda versão, gerenciador de pacotes e comando listado está apoiado por algum arquivo real do repositório.
- Confirme que o resumo da arquitetura cita diretórios, projetos, módulos ou entrypoints existentes.
- Confirme que as orientações não exigem ferramentas, credenciais ou fluxos que não aparecem no repositório.
- Informe o caminho criado e mencione pontos importantes que o usuário ainda deve confirmar.
