# NGINX Lynis Report Viewer

Este projeto disponibiliza um portal web simples para visualização de relatórios do [Lynis](https://cisofy.com/lynis/), usando NGINX como servidor web.

## Estrutura

- `html/`: Contém o `index.html` com o visualizador interativo.
- `nginx/`: Arquivo de configuração para o NGINX.
- `scripts/`: Scripts de setup, deploy e geração de relatórios.

## Como usar

```bash
# 1. Preparar o ambiente (instalação e permissões)
./scripts/01_setup.sh

# 2. Fazer o deploy do site
./scripts/02_deploy.sh

# 3. Gerar um relatório do Lynis
./scripts/03_generate-report.sh
