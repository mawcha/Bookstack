#!/usr/bin/env bash
set -Eeuo pipefail

DOMAIN="${1:-}"
SERVER_IP="${2:-}"
BOOKSTACK_DIR="/var/www/bookstack"
INSTALLER_URL="https://codeberg.org/bookstack/devops/raw/branch/main/scripts/installation-ubuntu-24.04.sh"

if [[ "${EUID}" -ne 0 ]]; then
    echo "Jalankan script dengan sudo."
    exit 1
fi

if [[ -z "$DOMAIN" || -z "$SERVER_IP" ]]; then
    echo "Penggunaan: sudo bash setup.sh <domain> <server-ip>"
    exit 1
fi

if [[ -d "$BOOKSTACK_DIR" ]]; then
    echo "BookStack sudah ada. Instalasi dibatalkan."
    exit 1
fi

. /etc/os-release

if [[ "$ID" != "ubuntu" || "$VERSION_ID" != "24.04" ]]; then
    echo "Script hanya untuk Ubuntu Server 24.04."
    exit 1
fi

apt-get update
apt-get install -y wget ca-certificates

TEMP_INSTALLER="$(mktemp)"
trap 'rm -f "$TEMP_INSTALLER"' EXIT

wget -O "$TEMP_INSTALLER" "$INSTALLER_URL"
chmod +x "$TEMP_INSTALLER"
bash "$TEMP_INSTALLER" "$SERVER_IP"

if [[ ! -f "$BOOKSTACK_DIR/.env" ]]; then
    echo "File konfigurasi BookStack tidak ditemukan."
    exit 1
fi

sed -i "s|^APP_URL=.*|APP_URL=https://${DOMAIN}|" \
    "$BOOKSTACK_DIR/.env"

cd "$BOOKSTACK_DIR"
php artisan config:clear
