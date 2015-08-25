Set-Alias top Get-TopProcesses

function Get-TopProcesses {
<#
.SYNOPSIS
    
.DESCRIPTION
    
.EXAMPLE

#>

    $saveY = [console]::CursorTop
    $saveX = [console]::CursorLeft

    while ($true) {
        Get-Process | Sort -Descending CPU | Select -First 30;
        Sleep -Seconds 2;
        [console]::setcursorposition($saveX,$saveY+3)
    }
}