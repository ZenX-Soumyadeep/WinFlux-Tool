Write-Host "WinFlux Tool Started"

. .\core\backup.ps1
. .\modules\services.ps1

Backup-Services
Disable-XboxServices