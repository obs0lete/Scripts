#function Reset-NetworkAdaptors {
    [CmdletBinding()]
    param(
        [switch]$Enable,
        [switch]$Disable
    )
    # Test if we are running as an administrator.
    $ErrorActionPreference = "Stop"
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
                [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "You are not running PowerShell with Administrator Rights.`nPlease re-launch PowerShell with Administrator Rights."
        break
    }

    # Get the network adaptors
    $NetworkAdaptors = Get-NetAdapter |
    Select-Object Name, InterfaceDescription, Status
    ""
    for ($i = 0; $i -lt $NetworkAdaptors.Count; $i++) {
        Write-Host "$($i+1): $($NetworkAdaptors[$i].Name) `r`n Description: $($NetworkAdaptors[$i].InterfaceDescription) `r`n Status: $($NetworkAdaptors[$i].Status) `r`n"
    }
    [int]$getAdaptorNumber = Read-Host "Enter a number to select an adaptor"
    $result = $($NetworkAdaptors[$getAdaptorNumber - 1]) |
    Select-Object Name, @{Name = "Interface"; Expression = { $_.InterfaceDescription } }, Status
    $Name = $result.Name
    ""

    if ($Enable) {
        Write-Host "Enabling $Name..."
        Enable-NetAdapter -Name $result.Name -Confirm:$false
    }
    
    if ($Disable) {
        Write-Host "Disabling $Name..."
        Disable-NetAdapter -Name $result.Name -Confirm:$false
    }
    # Show adaptor status
    Write-Host "Showing adaptor status:"
    Get-NetAdapter | Select-Object Name, @{Name = "Interface"; Expression = { $_.InterfaceDescription } }, Status
#}