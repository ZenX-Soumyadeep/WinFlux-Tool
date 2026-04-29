Write-Host "WinFlux Tool Started"

. .\core\backup.ps1
. .\modules\services.ps1

Write-Host "1. Apply Tweaks"
Write-Host "2. Restore Backup"

$choice = Read-Host "Choose option"

if ($choice -eq "1") {
    Backup-Services
    Disable-XboxServices
}
elseif ($choice -eq "2") {
    Restore-Services
}
else {
    Write-Host "Invalid option"
}