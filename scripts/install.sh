#!/bin/bash
# Agent Zero Otonom Ajan - Tam Otomatik Kurulum
# Serdar Kaptan
set -euo pipefail

CONTAINER_NAME="${A0_CONTAINER:-agent-zero-otonom}"
PORT="${A0_PORT:-5080}"
READY_TIMEOUT="${A0_READY_TIMEOUT:-120}"
PROFILE_DIR="/a0/usr/agents/otonom"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

fail() {
    echo "HATA: $*" >&2
    exit 1
}

echo "=== Agent Zero Otonom Ajan Kurulumu ==="
echo "Tasarım: Serdar Kaptan"

command -v docker >/dev/null 2>&1 || fail "Docker bulunamadı. Önce Docker kurun."
command -v curl >/dev/null 2>&1 || fail "curl bulunamadı. Hazır olma kontrolü için curl gerekli."
[ -f "$REPO_DIR/profiles/otonom/agent.yaml" ] || fail "Profil dosyası yok: $REPO_DIR/profiles/otonom/agent.yaml"
[ -f "$REPO_DIR/profiles/otonom/prompts/agent.system.main.specifics.md" ] || fail "Sistem promptu yok: profiles/otonom/prompts/agent.system.main.specifics.md"

echo "Agent Zero çekiliyor..."
docker pull agent0ai/agent-zero || fail "docker pull başarısız."

# Eski konteyner varsa kaldır (yoksa bu bir hata değil)
if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    echo "Eski konteyner kaldırılıyor: $CONTAINER_NAME"
    docker rm -f "$CONTAINER_NAME" >/dev/null || fail "Eski konteyner kaldırılamadı: $CONTAINER_NAME"
fi

echo "Konteyner başlatılıyor..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$PORT:80" \
  -v a0_usr:/a0/usr \
  --add-host=host.docker.internal:host-gateway \
  agent0ai/agent-zero >/dev/null || fail "Konteyner başlatılamadı."

echo "Web arayüzü bekleniyor (en fazla ${READY_TIMEOUT} sn)..."
elapsed=0
until curl -fsS -o /dev/null "http://localhost:$PORT/"; do
    state="$(docker inspect -f '{{.State.Status}}' "$CONTAINER_NAME" 2>/dev/null || echo yok)"
    [ "$state" = "running" ] || fail "Konteyner çalışmıyor (durum: $state). Log: docker logs $CONTAINER_NAME"
    [ "$elapsed" -lt "$READY_TIMEOUT" ] || fail "Web arayüzü ${READY_TIMEOUT} sn içinde hazır olmadı. Log: docker logs $CONTAINER_NAME"
    sleep 2
    elapsed=$((elapsed + 2))
done
echo "Web arayüzü hazır (${elapsed} sn)."

echo "Profil ve faz dosyaları kopyalanıyor..."
docker exec "$CONTAINER_NAME" mkdir -p "$PROFILE_DIR" /a0/usr/phases || fail "Konteyner içinde klasör oluşturulamadı."
docker cp "$REPO_DIR/profiles/otonom/." "$CONTAINER_NAME:$PROFILE_DIR/" || fail "Profil kopyalanamadı -> $PROFILE_DIR"
docker cp "$REPO_DIR/phases/." "$CONTAINER_NAME:/a0/usr/phases/" || fail "Faz dosyaları kopyalanamadı -> /a0/usr/phases"
docker exec "$CONTAINER_NAME" test -f "$PROFILE_DIR/prompts/agent.system.main.specifics.md" \
    || fail "Sistem promptu konteynerde bulunamadı: $PROFILE_DIR/prompts/agent.system.main.specifics.md"

echo ""
echo "=== Kurulum Tamam ==="
echo "Web UI: http://localhost:$PORT"
echo "Profile: otonom seçin"
echo ""
echo "Acil durdurma bekçisi:"
echo "python3 phases/06-acil-durdurma/watchdog.py"
echo ""
echo "Serdar Kaptan - Otonom Ajan Sistemi"
