#!/bin/bash
# Agent Zero Otonom Ajan - Tam Otomatik Kurulum
# Serdar Kaptan
set -e

echo "=== Agent Zero Otonom Ajan Kurulumu ==="
echo "Tasarım: Serdar Kaptan"

if ! command -v docker &> /dev/null; then
    echo "Docker bulunamadı. Önce Docker kurun."
    exit 1
fi

echo "Agent Zero çekiliyor..."
docker pull agent0ai/agent-zero

CONTAINER_NAME="agent-zero-otonom"
PORT=5080

docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "Konteyner başlatılıyor..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:80 \
  -v a0_usr:/a0/usr \
  --add-host=host.docker.internal:host-gateway \
  agent0ai/agent-zero

sleep 8

echo "Profil ve faz dosyaları kopyalanıyor..."
docker cp ./profiles/otonom $CONTAINER_NAME:/a0/usr/agents/otonom 2>/dev/null || true
docker cp ./phases $CONTAINER_NAME:/a0/usr/phases 2>/dev/null || true

echo ""
echo "=== Kurulum Tamam ==="
echo "Web UI: http://localhost:$PORT"
echo "Profile: otonom seçin"
echo ""
echo "Acil durdurma bekçisi:"
echo "python3 phases/06-acil-durdurma/watchdog.py"
echo ""
echo "Serdar Kaptan - Otonom Ajan Sistemi"
