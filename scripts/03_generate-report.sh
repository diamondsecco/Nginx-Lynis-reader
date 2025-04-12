#!/bin/bash
# scripts/generate-report.sh

AUDITOR="Renato"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H-%M-%S)
REPORT_DIR="/var/www/lynis-portal/lynis-reports"

FILENAME="lynis-report-${DATE}-${TIME}.txt"

echo "📝 Gerando relatório Lynis..."
sudo lynis audit system --auditor "$AUDITOR" \
  --report-file "/var/log/lynis-report.dat"

echo "📄 Extraindo dados relevantes..."
sudo grep -E 'os_version=|kernel_version=|linux_kernel_version=|hostname=|hardening_index=' /var/log/lynis-report.dat > "${REPORT_DIR}/${FILENAME}"

echo "🔒 Ajustando permissões..."
sudo chown -R nginx:nginx "$REPORT_DIR"

echo "✅ Relatório salvo em: ${REPORT_DIR}/${FILENAME}"
