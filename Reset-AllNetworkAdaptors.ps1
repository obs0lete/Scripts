#function Reset-AllNetworkAdaptors {
    # Test if we are running as an administrator.
    $ErrorActionPreference = "Stop"
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator"))
        {
            Write-Warning "You are not running PowerShell with Administrator Rights.`nPlease re-launch PowerShell with Administrator Rights."
            break
        }
    $adaptors = Get-NetAdapter | Select-Object -ExpandProperty Name
    forEach ($i in $adaptors) {
        Write-Host "Disabling $i..."
        Disable-NetAdapter -Name $i -Confirm:$false

        Write-Host "Enabling $i..."
        Enable-NetAdapter -Name $i -Confirm:$false
        ""
    }
#}