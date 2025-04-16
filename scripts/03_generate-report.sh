#!/bin/bash
# scripts/generate-report.sh

AUDITOR="Renato"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H-%M-%S)
REPORT_DIR="/var/www/lynis-portal/lynis-reports"
FILENAME="lynis-report-${DATE}-${TIME}.txt"
TMPFILE="/tmp/lynis-tmp-${DATE}-${TIME}.txt"

echo "📝 Gerando relatório Lynis..."
sudo lynis audit system --auditor "$AUDITOR" \
  --report-file "/var/log/lynis-report.dat"

echo "📄 Extraindo dados relevantes..."
FIELDS=(
  "hostname"
  "os_version"
  "kernel_version"
  "linux_kernel_version"
  "hardening_index"
  "firewall_active"
  "auditd"
  "ntp_synced"
  "ssh_permit_root_login"
  "file_integrity_tool_installed"
)

> "$TMPFILE"
for field in "${FIELDS[@]}"; do
  VALUE=$(grep -E "^${field}=" /var/log/lynis-report.dat)
  if [[ -z "$VALUE" ]]; then
    echo "${field}=não encontrado" >> "$TMPFILE"
  else
    echo "$VALUE" >> "$TMPFILE"
  fi
done

sudo mv "$TMPFILE" "${REPORT_DIR}/${FILENAME}"

echo "🔒 Ajustando permissões..."
sudo chown -R nginx:nginx "$REPORT_DIR"
sudo chcon -R -t httpd_sys_content_t "$REPORT_DIR"

echo "✅ Relatório salvo em: ${REPORT_DIR}/${FILENAME}"
