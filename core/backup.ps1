function Backup-Services {
    $path = ".\backups"
    if (!(Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }

    Get-Service | Select Name, Status | ConvertTo-Json | Out-File "$path\services.json"
    Write-Host "Backup created"
}