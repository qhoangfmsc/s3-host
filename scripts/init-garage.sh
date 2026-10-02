#!/usr/bin/env bash
# Khởi tạo Garage một lần: layout 1 node, bucket công khai, access key.
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; source .env; set +a

g() { docker compose exec -T garage /garage "$@"; }

NODE_ID=$(g status | awk '/==== HEALTHY NODES ====/{f=1;next} f&&NF&&$1!="ID"{print $1; exit}')
echo "Node: $NODE_ID"

g layout assign -z dc1 -c "${GARAGE_CAPACITY:-100G}" "$NODE_ID"
g layout apply --version 1

g bucket create "$PUBLIC_BUCKET"
g bucket website --allow "$PUBLIC_BUCKET"

g key create app-key
g bucket allow --read --write --owner "$PUBLIC_BUCKET" --key app-key
echo
echo "Lưu Key ID / Secret ở trên vào nơi an toàn (secret chỉ hiện một lần)."
