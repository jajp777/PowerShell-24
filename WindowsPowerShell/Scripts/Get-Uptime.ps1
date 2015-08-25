Set-Alias uptime Get-Uptime

function Get-Uptime([String]$Computer = '.') {
<#
.SYNOPSIS
    
.DESCRIPTION
    
.EXAMPLE

#>

    $os = Get-WmiObject win32_operatingsystem
    $uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
    $Display = "Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes"
    Write-Output $Display

}
