### My PowerShell Profile ###

## Environment variables go here
[Environment]::SetEnvironmentVariable("UserProfile", "${env:HomeDrive}${env:HomePath}")
[Environment]::SetEnvironmentVariable("Home", "${env:UserProfile}")
    # Set the "~" shortcut value for the FileSystem provider
(Get-PSProvider -PSProvider 'FileSystem').Home = ${Home}

## Script variables go here
Set-Variable -Name RunningDirectory -Value $(Split-Path -Path ${myInvocation}.MyCommand.Path)
    # Check for Administrator elevation
Set-Variable -Name UserInfo -Value $([System.Security.Principal.WindowsIdentity]::GetCurrent())
Set-Variable -Name CheckGroup -Value $(New-Object -TypeName System.Security.Principal.WindowsPrincipal -ArgumentList (${UserInfo}))
Set-Variable -Name AdminPrivCheck -Value $([System.Security.Principal.WindowsBuiltInRole]::Administrator)
Set-Variable -Name AdminPrivSet -Value $(${CheckGroup}.IsInRole(${AdminPrivCheck}))

## Aliases go here
    #~~~

## User modules to import go here
Import-Module -Name Vim-PS
Import-Module -Name SSH-PS

## Functions and other gibblets here
    # Print the user and host:
Function Prompt {
        # Check for Administrator elevation
    If (${AdminPrivSet}) {
        Write-Host -Object ("${env:UserName}") -NoNewline -ForegroundColor Red
    } else {
        Write-Host -Object ("${env:UserName}") -NoNewline -ForegroundColor Green
    }

    Write-Host -Object ("@") -NoNewline -ForegroundColor Green
    Write-Host -Object ("${env:ComputerName}") -NoNewline -ForegroundColor Green
        # Print the working directory:
    Write-Host -Object (":") -NoNewline -ForegroundColor Cyan
        # Replace string matching homedir with tilde
    Write-Host -Object ($((Get-Location).Path).Replace(${Home},"~")) -NoNewLine -ForegroundColor Cyan

    If (${AdminPrivSet}) {
        Write-Host -Object ("#") -NoNewline -ForegroundColor Red
        return " "
    }
    else {
        Write-Host -Object ("$") -NoNewline -ForegroundColor White
        return " "
    }
}

    # Change the size of the console window
Function Reset-ConsoleWindow {
    If (${Host}.Name -eq "ConsoleHost") {
        Set-Variable -Name Shell -Value $(${Host}.UI.RawUI)
        (Get-Variable -Name Shell -ValueOnly).WindowTitle = "PowerShell"
        Set-Variable -Name Size -Value $(${Shell}.WindowSize)
        (Get-Variable -Name Size -ValueOnly).Width = "80"
        (Get-Variable -Name Size -ValueOnly).Height = "40"
        (Get-Variable -Name Shell -ValueOnly).WindowSize = ${Size}
        Set-Variable -Name Size -Value $(${Shell}.BufferSize)
        (Get-Variable -Name Size -ValueOnly).Width = "80"
        (Get-Variable -Name Size -ValueOnly).Height = "5000"
        (Get-Variable -Name Shell -ValueOnly ).BufferSize = ${Size}
        Clear-Host
    }
}
    # To edit the Powershell Profile
Function Edit-Profile {
    Vim ${Profile}
}
    # To edit Vim settings
Function Edit-Vimrc {
    Vim ${Home}\_vimrc
}

    # Import user scripts
Set-Variable -Name ScriptDir -Value $(Join-Path -Path ${RunningDirectory} -ChildPath "Scripts")
Get-ChildItem -Path ${ScriptDir} | Where-Object {
    $_.Name -like "*.ps1"
} | ForEach-Object {
    . $_.FullName
}
