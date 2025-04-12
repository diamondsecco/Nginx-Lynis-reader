    #!/bin/bash

    set -e

    DEST="/var/www/lynis-portal"
    NGINX_USER="nginx"

    echo "[+] Copiando arquivos HTML..."
    sudo mkdir -p "$DEST"
    sudo cp -r html/* "$DEST"

    echo "[+] Ajustando permissões..."
    sudo chown -R $NGINX_USER:$NGINX_USER "$DEST"

    echo "[+] Copiando configuração NGINX..."
    sudo cp nginx/lynis-reports.conf /etc/nginx/conf.d/ #< não funciona detalhe pode term conflito com /etc/nginx/nginx.conf

    echo "[+] Ajustando permissões..."
    sudo chown -R $NGINX_USER:$NGINX_USER /etc/nginx/conf.d/lynis-reports.conf 

    echo "[+] Reiniciando NGINX..."
    sudo systemctl restart nginx
    nginx -t
    tail /var/log/nginx/*.log
    sudo systemctl reload nginx

    echo "[✔] Portal disponível em http://localhost/"
