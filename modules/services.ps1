function Disable-XboxServices {
    
    $config = Get-Content ".\config\services.json" | ConvertFrom-Json
    $services = $config.disable

    foreach ($svc in $services) {
        $service = Get-Service -Name $svc -ErrorAction SilentlyContinue

        if ($service) {
            try {
                if ($service.Status -ne "Stopped") {
                    Stop-Service -Name $svc -Force -ErrorAction Stop
                }

                Set-Service -Name $svc -StartupType Disabled -ErrorAction Stop
                Write-Host "$svc disabled successfully"
            }
            catch {
                Write-Host "$svc FAILED: $($_.Exception.Message)"
            }
        } else {
            Write-Host "$svc not found"
        }
    }
}