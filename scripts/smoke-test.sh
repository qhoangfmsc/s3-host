#!/usr/bin/env bash
# Kiểm tra nhanh: upload file 20MB (multipart), tải lại so checksum, mở qua URL công khai, rồi dọn.
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; source .env; set +a
F=smoke-test.bin
head -c 20971520 /dev/urandom > "$F"
trap 'rm -f "$F" "$F.back"' EXIT
./scripts/rclone.sh copyto "/work/$F" "S3:$PUBLIC_BUCKET/$F" --s3-chunk-size 5M --s3-upload-cutoff 5M
./scripts/rclone.sh copyto "S3:$PUBLIC_BUCKET/$F" "/work/$F.back"
[ "$(shasum -a 256 < "$F")" = "$(shasum -a 256 < "$F.back")" ] && echo "OK  upload/tải: checksum khớp"
CODE=$(curl -sk -o /dev/null -w "%{http_code}" "https://files.$BASE_DOMAIN/$F" --resolve "files.$BASE_DOMAIN:443:127.0.0.1")
[ "$CODE" = 200 ] && echo "OK  URL công khai: https://files.$BASE_DOMAIN/$F" || { echo "LỖI URL công khai: $CODE"; exit 1; }
./scripts/rclone.sh deletefile "S3:$PUBLIC_BUCKET/$F"
echo "Tất cả OK"
