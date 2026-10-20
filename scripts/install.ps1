# Windows PowerShell - Agent Zero Otonom Ajan Kurulumu
# Serdar Kaptan

Write-Host "=== Agent Zero Otonom Ajan Kurulumu ===" -ForegroundColor Green
Write-Host "Tasarım: Serdar Kaptan" -ForegroundColor Cyan

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker bulunamadı." -ForegroundColor Red
    exit 1
}

docker pull agent0ai/agent-zero
$containerName = "agent-zero-otonom"
$port = 5080

docker stop $containerName 2>$null
docker rm $containerName 2>$null

docker run -d --name $containerName -p "${port}:80" -v a0_usr:/a0/usr --add-host=host.docker.internal:host-gateway agent0ai/agent-zero
Start-Sleep -Seconds 10

docker cp ./profiles/otonom "${containerName}:/a0/usr/agents/otonom" 2>$null
docker cp ./phases "${containerName}:/a0/usr/phases" 2>$null

Write-Host "=== Tamamlandı ===" -ForegroundColor Green
Write-Host "http://localhost:$port"
Write-Host "Profile: otonom"
Write-Host "Serdar Kaptan"
