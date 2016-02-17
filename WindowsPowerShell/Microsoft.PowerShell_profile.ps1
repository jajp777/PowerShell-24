### My PowerShell Profile ###

## Script variables go here
Set-Variable -Name Profile_Directory -Value $(Split-Path -Path ${myInvocation}.MyCommand.Path) -Scope Private
Set-Variable -Name Profile_Main -Value $(Join-Path -Path ${Profile_Directory} -ChildPath "profile.ps1") -Scope Private
Set-Variable -Name Profile_Exist -Value $(Test-Path -Path ${Profile_Main}) -Scope Private
Set-Variable -Name MOTD_Main -Value $(Join-Path -Path ${Profile_Directory} -ChildPath "Scripts/Get-MOTD.ps1") -Scope Private
Set-Variable -Name MOTD_Exist -Value $(Test-Path -Path ${MOTD_Main}) -Scope Private

if ("${Profile_Exist}" -eq "True") {
    . ${Profile_Main}
}

Set-Location -Path ${Home}
Reset-ConsoleWindow

if ("${MOTD_Exist}" -eq "True") {
    Get-MOTD
}
