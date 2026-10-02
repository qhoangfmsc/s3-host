#!/usr/bin/env bash
# Sao lưu toàn bộ bucket công khai ra thư mục ./backups/<bucket> (nên trỏ thư mục này sang ổ ngoài).
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; source .env; set +a
./scripts/rclone.sh sync "S3:$PUBLIC_BUCKET" "/work/backups/$PUBLIC_BUCKET" --progress
echo "Backup xong: backups/$PUBLIC_BUCKET"
