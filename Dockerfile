# Dockerfile เดิม
FROM golang:alpine as build
RUN apk add --no-cache curl unzip
RUN curl -L https://github.com/pocketbase/pocketbase/releases/download/v0.22.21/pocketbase_0.22.21_linux_amd64.zip -o pocketbase.zip && \
    unzip pocketbase.zip && \
    rm pocketbase.zip
WORKDIR /pb
EXPOSE 8090

# เพิ่ม volume mount ที่ data directory
VOLUME /pb_data

CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data"]
