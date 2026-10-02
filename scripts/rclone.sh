#!/usr/bin/env bash
# Chạy rclone (qua Docker) với remote tên "S3" trỏ vào Garage. Ví dụ: ./scripts/rclone.sh lsl S3:media
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; source .env; set +a
mkdir -p backups
exec docker run --rm --network s3host_default \
  -v "$PWD:/work" -w /work \
  -e RCLONE_CONFIG_S3_TYPE=s3 -e RCLONE_CONFIG_S3_PROVIDER=Other \
  -e RCLONE_CONFIG_S3_ACCESS_KEY_ID="$S3_ACCESS_KEY_ID" \
  -e RCLONE_CONFIG_S3_SECRET_ACCESS_KEY="$S3_SECRET_ACCESS_KEY" \
  -e RCLONE_CONFIG_S3_ENDPOINT=http://garage:3900 -e RCLONE_CONFIG_S3_REGION=garage \
  rclone/rclone "$@"
