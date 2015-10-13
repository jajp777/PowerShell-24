# My PowerShell Profile

## Script variables go here
Set-Variable -Name Running_Directory -Value $(Split-Path -Path ${myInvocation}.MyCommand.Path)
Set-Variable -Name Main_Profile -Value $(Join-Path -Path ${Running_Directory} -ChildPath "profile.ps1")
Set-Variable -Name Profile_Exist -Value $(Test-Path -Path ${Main_Profile})

if ("${Profile_Exist}" -eq "True") {
    . ${Main_Profile}
}

Set-Location -Path ${Home}
