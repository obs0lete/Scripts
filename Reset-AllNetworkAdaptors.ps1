# Quick script that will reset all the network adaptors.
# you can run as-is or save it to your PowerShell profile.
# Note that this will require an elevated prompt to run.
process {
    $adaptors = Get-NetAdapter | Select-Object -ExpandProperty Name
    forEach ($i in $adaptors) {
        Write-Host "Disabling $i..."
        Disable-NetAdapter -Name $i -Confirm:$false

        Write-Host "Enabling $i..."
        Enable-NetAdapter -Name $i -Confirm:$false
        ""
    }
}