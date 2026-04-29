function Disable-XboxServices {
    $services = @(
        "XboxGipSvc",
        "XblAuthManager",
        "XblGameSave",
        "XboxNetApiSvc"
    )

    foreach ($svc in $services) {
        if (Get-Service -Name $svc -ErrorAction SilentlyContinue) {
            Stop-Service -Name $svc -Force
            Set-Service -Name $svc -StartupType Disabled
            Write-Host "$svc disabled"
        } else {
            Write-Host "$svc not found"
        }
    }
}