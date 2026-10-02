# s3host

Kho ảnh riêng chạy bằng Docker (Garage = S3, Appwrite = backend).

**Bật:** `docker compose up -d` rồi `cd appwrite && docker compose up -d`
**Tắt:** `docker compose down` (và trong `appwrite/` cũng vậy)
**Appwrite:** http://localhost:8080 (đăng nhập: `appwrite/admin-login.txt`)
**Đổi domain:** sửa `BASE_DOMAIN` trong `.env`, và `_APP_DOMAIN` trong `appwrite/.env`, rồi bật lại
**Domain thật cần thêm:** DNS bản ghi A `s3`, `files`, `appwrite` → IP nhà; router mở cổng 80, 443
**Chỉ thử trên máy:** `BASE_DOMAIN=localhost`
**Link ảnh:** `https://files.<BASE_DOMAIN>/<tên-file>`
**Kiểm tra / sao lưu:** `./scripts/smoke-test.sh` / `./scripts/backup.sh`

Lưu ý: máy tắt thì tắt hết. Đừng xóa `data/`. Đừng đưa `.env` lên git.
