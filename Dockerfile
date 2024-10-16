# ใช้ image ของ Golang เพื่อติดตั้งและ build PocketBase
FROM golang:alpine as build

# ตั้งค่าโฟลเดอร์ทำงานใน container
WORKDIR /app

# ดาวน์โหลด PocketBase binary ล่าสุดจาก GitHub
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip && \
    unzip pocketbase_0.22.21_linux_amd64.zip && \
    chmod +x pocketbase

# สร้าง stage ที่สองเพื่อรันแอปพลิเคชัน PocketBase
FROM alpine:latest
WORKDIR /app

# คัดลอกไฟล์ไบนารีจาก stage build มายัง container
COPY --from=build /app/pocketbase /app/pocketbase

# เปิด port ที่ต้องการใช้
EXPOSE 8090

# คำสั่งสำหรับรัน PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
