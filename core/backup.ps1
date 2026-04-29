function Backup-Services {
    
    $config = Get-Content ".\config\services.json" | ConvertFrom-Json
    $services = $config.disable
    
    $path = ".\backups"
    if (!(Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }

    $data = @()

    foreach ($svc in $services) {
        $s = Get-Service -Name $svc -ErrorAction SilentlyContinue
        if ($s) {
            $data += [PSCustomObject]@{
                Name = $s.Name
                Status = $s.Status
                StartType = (Get-WmiObject Win32_Service -Filter "Name='$svc'").StartMode
            }
        }
    }

    $data | ConvertTo-Json | Out-File "$path\services.json"

    Write-Host "Backup created (targeted)"
}
function Restore-Services {
    $path = ".\backups\services.json"

    if (!(Test-Path $path)) {
        Write-Host "No backup found"
        return
    }

    $backup = Get-Content $path | ConvertFrom-Json

    foreach ($svc in $backup) {
        try {
            Set-Service -Name $svc.Name -StartupType $svc.StartType -ErrorAction Stop

            if ($svc.Status -eq "Running") {
                Start-Service -Name $svc.Name -ErrorAction Stop
            }

            Write-Host "$($svc.Name) restored"
        }
        catch {
            Write-Host "$($svc.Name) FAILED: $($_.Exception.Message)"
        }
    }
}