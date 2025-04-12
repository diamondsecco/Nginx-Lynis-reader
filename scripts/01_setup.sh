#!/bin/bash
# scripts/setup.sh

set -e

echo "🔧 Instalando NGINX e ferramentas necessárias..."
sudo dnf install -y nginx policycoreutils-python-utils firewalld lynis

echo "🚀 Habilitando e iniciando serviços..."
sudo systemctl enable --now nginx firewalld

echo "🔥 Liberando NGINX no Firewalld..."
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

echo "🔐 Ajustando permissões e contexto SELinux..."
sudo mkdir -p /var/www/lynis-portal/lynis-reports
sudo chown -R nginx:nginx /var/www/lynis-portal
sudo chmod -R 755 /var/www/lynis-portal
sudo chcon -Rt httpd_sys_content_t /var/www/lynis-portal 2>/dev/null

if command -v semanage &> /dev/null; then
    sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/lynis-portal(/.*)?"
    sudo restorecon -Rv /var/www/lynis-portal
else
    echo "⚠️ 'semanage' não encontrado. Pulando configuração SELinux..."
fi

echo "✅ Ambiente preparado para o deploy."
