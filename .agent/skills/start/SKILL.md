---
name: start
description: Inspecione um workspace de desenvolvimento com IA no início da sessão, lendo as instruções raiz e mapeando os projetos gerenciados. Use quando o usuário invocar /start ou solicitar uma visão geral do workspace; não use para trabalhar em um projeto específico.
---

# Inicializar o contexto do workspace

Use esta skill para estabelecer uma visão mínima e confiável do workspace antes de iniciar o trabalho. A descoberta é somente de leitura, exceto pela preparação mínima da documentação descrita abaixo.

## Procedimento

1. Localize e leia o `AGENTS.md` na raiz do workspace. Trate-o como a fonte de instruções que rege o workspace.
2. Inspecione os diretórios imediatos em `projects/`, caso esse diretório exista. Cada diretório imediato é um possível projeto gerenciado.
3. Para cada possível projeto, leia apenas o `AGENTS.md` existente em sua raiz. Não faça varredura recursiva, não leia código-fonte, não inspecione dependências nem carregue a documentação durante a inicialização.
4. Para cada projeto, verifique se existe a pasta `documentation/`. Se ela não existir, crie-a e adicione um `README.md` com uma breve descrição informando que aquela é a pasta de documentação do projeto. Se a pasta já existir, preserve seu conteúdo.
5. Apresente um resumo conciso do workspace contendo:
   - se o `AGENTS.md` raiz foi encontrado e lido;
   - os projetos gerenciados encontrados;
   - para cada projeto, se existe um `AGENTS.md` local e qual contexto geral ele fornece;
   - se a pasta `documentation/` já existia ou precisou ser criada;
   - caminhos esperados ausentes ou situações inesperadas, como a inexistência de `projects/` ou um projeto sem instruções locais.

## Limites

- Não infira projetos fora de `projects/`.
- Não trate arquivos ou diretórios internos de um projeto como projetos separados.
- Não faça outras modificações no workspace como parte da inicialização. A única alteração permitida é criar a estrutura mínima `documentation/README.md` quando ela estiver ausente.
- Siga o `AGENTS.md` de um projeto somente depois que ele for selecionado para trabalho. Nesta inicialização, leia-o apenas para estabelecer o contexto geral.
