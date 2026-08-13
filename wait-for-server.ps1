param(
    [ValidateRange(2, 300)]
    [int]$CheckEverySeconds = 10
)

$containerId = docker compose ps -q minecraft

if ([string]::IsNullOrWhiteSpace($containerId)) {
    Write-Host "Minecraft is not running. Start it first with: docker compose up -d" -ForegroundColor Red
    exit 1
}

Write-Host "Server is not ready yet. Forge is starting for the first time..." -ForegroundColor Yellow

while ($true) {
    $status = docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' $containerId

    if ($status -eq 'healthy') {
        Write-Host "Server is ready! Players can now join." -ForegroundColor Green
        exit 0
    }

    if ($status -eq 'exited' -or $status -eq 'dead') {
        Write-Host "Server stopped before it was ready. Check the error with: docker compose logs minecraft" -ForegroundColor Red
        exit 1
    }

    Write-Host "Not ready yet (status: $status). Checking again in $CheckEverySeconds seconds..." -ForegroundColor Yellow
    Start-Sleep -Seconds $CheckEverySeconds
}
