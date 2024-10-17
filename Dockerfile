# Stage 1: Build PocketBase binary
FROM golang:alpine as build
WORKDIR /app

# ดาวน์โหลด PocketBase binary ล่าสุดจาก GitHub
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip && \
    unzip pocketbase_0.22.21_linux_amd64.zip && \
    chmod +x pocketbase

# Stage 2: Run PocketBase with volume support
FROM alpine:latest
WORKDIR /app

# คัดลอกไบนารีจาก stage build มายัง container
COPY --from=build /app/pocketbase /app/pocketbase

# สร้างโฟลเดอร์สำหรับเก็บข้อมูล
RUN mkdir -p /app/pb_data

# กำหนดให้ /app/pb_data เป็น volume (สำหรับเก็บข้อมูลถาวร)
VOLUME /app/pb_data

# เปิดพอร์ตที่ Render จะส่งผ่านใน environment variable `PORT`
# และตั้งค่า default เป็น 8090 หาก `PORT` ไม่ได้ถูกกำหนด
CMD ["./pocketbase", "serve", "--http=0.0.0.0:${PORT:-8090}", "--dir=/app/pb_data"]
