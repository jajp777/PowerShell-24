#!C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

$ConsoleKeyMain="HKCU:\Console"

Function Set-ConsoleValues {

<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

#>
    # Set color values to match XTerm ANSI order and color
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable00 -Type DWORD -Value 0x00562401
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable01 -Type DWORD -Value 0x00EE0000
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable02 -Type DWORD -Value 0x0000CD00
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable03 -Type DWORD -Value 0x00CDCD00
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable04 -Type DWORD -Value 0x000000CD
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable05 -Type DWORD -Value 0x00CD00CD
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable06 -Type DWORD -Value 0x0000CDCD
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable07 -Type DWORD -Value 0x00C0C0C0
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable08 -Type DWORD -Value 0x007F7F7F
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable09 -Type DWORD -Value 0x00FF5C5C
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable10 -Type DWORD -Value 0x0000FF00
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable11 -Type DWORD -Value 0x00FFFF00
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable12 -Type DWORD -Value 0x000000FF
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable13 -Type DWORD -Value 0x00FF00FF
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable14 -Type DWORD -Value 0x0000FFFF
    Set-ItemProperty -Path $ConsoleKeyMain -Name ColorTable15 -Type DWORD -Value 0x00FFFFFF

}