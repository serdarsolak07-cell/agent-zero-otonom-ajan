# Windows PowerShell - Agent Zero Otonom Ajan Kurulumu
# Serdar Kaptan
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$containerName = if ($env:A0_CONTAINER) { $env:A0_CONTAINER } else { "agent-zero-otonom" }
$port = if ($env:A0_PORT) { [int]$env:A0_PORT } else { 5080 }
$readyTimeout = if ($env:A0_READY_TIMEOUT) { [int]$env:A0_READY_TIMEOUT } else { 120 }
$profileDir = "/a0/usr/agents/otonom"
$repoDir = Split-Path -Parent $PSScriptRoot

function Fail([string]$msg) {
    Write-Host "HATA: $msg" -ForegroundColor Red
    exit 1
}

# Harici komutun çıkış kodunu kontrol et
function Invoke-Docker([string]$errMsg) {
    & docker @args
    if ($LASTEXITCODE -ne 0) { Fail $errMsg }
}

Write-Host "=== Agent Zero Otonom Ajan Kurulumu ===" -ForegroundColor Green
Write-Host "Tasarım: Serdar Kaptan" -ForegroundColor Cyan

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) { Fail "Docker bulunamadı." }
if (-not (Test-Path "$repoDir/profiles/otonom/agent.yaml")) { Fail "Profil dosyası yok: profiles/otonom/agent.yaml" }
if (-not (Test-Path "$repoDir/profiles/otonom/prompts/agent.system.main.specifics.md")) { Fail "Sistem promptu yok: profiles/otonom/prompts/agent.system.main.specifics.md" }

Invoke-Docker "docker pull başarısız." pull agent0ai/agent-zero

& docker container inspect $containerName *> $null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Eski konteyner kaldırılıyor: $containerName"
    Invoke-Docker "Eski konteyner kaldırılamadı." rm -f $containerName
}

Invoke-Docker "Konteyner başlatılamadı." run -d --name $containerName -p "${port}:80" -v a0_usr:/a0/usr --add-host=host.docker.internal:host-gateway agent0ai/agent-zero

Write-Host "Web arayüzü bekleniyor (en fazla $readyTimeout sn)..."
$elapsed = 0
while ($true) {
    try {
        Invoke-WebRequest -Uri "http://localhost:$port/" -UseBasicParsing -TimeoutSec 5 | Out-Null
        break
    } catch {
        $state = (& docker inspect -f "{{.State.Status}}" $containerName 2>$null)
        if ($state -ne "running") { Fail "Konteyner çalışmıyor (durum: $state). Log: docker logs $containerName" }
        if ($elapsed -ge $readyTimeout) { Fail "Web arayüzü $readyTimeout sn içinde hazır olmadı. Log: docker logs $containerName" }
        Start-Sleep -Seconds 2
        $elapsed += 2
    }
}
Write-Host "Web arayüzü hazır ($elapsed sn)."

Invoke-Docker "Konteyner içinde klasör oluşturulamadı." exec $containerName mkdir -p $profileDir /a0/usr/phases
Invoke-Docker "Profil kopyalanamadı -> $profileDir" cp "$repoDir/profiles/otonom/." "${containerName}:$profileDir/"
Invoke-Docker "Faz dosyaları kopyalanamadı -> /a0/usr/phases" cp "$repoDir/phases/." "${containerName}:/a0/usr/phases/"
Invoke-Docker "Sistem promptu konteynerde bulunamadı." exec $containerName test -f "$profileDir/prompts/agent.system.main.specifics.md"

Write-Host "=== Kurulum Tamam ===" -ForegroundColor Green
Write-Host "http://localhost:$port"
Write-Host "Profile: otonom"
Write-Host "Serdar Kaptan"
