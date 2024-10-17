FROM alpine:3.14

# ติดตั้ง curl เพื่อดาวน์โหลด pocketbase
RUN apk add --no-cache curl

# ดาวน์โหลด Pocketbase
RUN curl -L https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip -o pocketbase.zip

# แตกไฟล์
RUN unzip pocketbase.zip && rm pocketbase.zip

# กำหนด working directory
WORKDIR /pb

# copy ไฟล์ไปยัง working directory
COPY . .

# เปิด port ที่ต้องใช้
EXPOSE 8090

# คำสั่งรัน Pocketbase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
