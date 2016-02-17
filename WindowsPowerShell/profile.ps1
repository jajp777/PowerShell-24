### My PowerShell Profile ###

## Environment variables go here
Set-Variable -Name Profile_Directory -Value $(Split-Path -Path ${myInvocation}.MyCommand.Path -Parent) -Scope Private
Set-Item -Path Env:\HOMEDRIVE -Value $("$((Get-Item ${Profile_directory}).PSDrive.Name):") -Force
Set-Item -Path Env:\HOMEPATH -Value $(Split-Path ((Get-Item ${Profile_Directory}).Parent.Parent.FullName) -NoQualifier) -Force
Set-Item -Path Env:\USERPROFILE -Value $((Get-Item ${Profile_Directory}).Parent.Parent.FullName) -Force
Set-Item -Path Env:\APPDATA -Value $(Join-Path -Path ${env:USERPROFILE} -ChildPath Appdata\Roaming -Resolve) -Force
Set-Item -Path Env:\LOCALAPPDATA -Value $(Join-Path -Path ${env:USERPROFILE} -ChildPath Appdata\Local -Resolve) -Force
Set-Item -Path Env:\TEMP -Value $(Join-Path -Path ${env:LOCALAPPDATA} -ChildPath Temp) -Force
Set-Item -Path Env:\TMP -Value $(${env:TEMP}) -Force
Set-Item -Path Env:\PSModulePath -Value $(${env:PSModulePath} + ";${Profile_Directory}\Modules") -Force
Set-Item -Path Env:\PATH -Value $(${env:PATH} + ";${Profile_Directory}\Stash\Bin64" + ";${Profile_Directory}\Stash\Bin") -Force

# Set output stream colors
$Host.PrivateData.ErrorForegroundColor = "Red"
$Host.PrivateData.ErrorBackgroundColor = "DarkMagenta"
$Host.PrivateData.WarningForegroundColor = "Red"
$Host.PrivateData.WarningBackgroundColor = "DarkMagenta"
$Host.PrivateData.DebugForegroundColor = "Yellow"
$Host.PrivateData.DebugBackgroundColor = "DarkMagenta"
$Host.PrivateData.VerboseForegroundColor = "Yellow"
$Host.PrivateData.VerboseBackgroundColor = "DarkMagenta"
$Host.PrivateData.ProgressForegroundColor ="Yellow"
$Host.PrivateData.ProgressBackgroundColor = "DarkCyan"

#[Environment]::SetEnvironmentVariable("Home", "${env:UserProfile}")
Set-Item -Path Env:\HOME -Value $(${env:USERPROFILE}) -Force
Set-Variable -Name HOME -Value $(${env:HOME}) -Force

# Set the "~" shortcut value for the FileSystem provider
(Get-PSProvider -PSProvider 'FileSystem').Home = ${HOME}
(Get-PSProvider -PSProvider 'Registry').Home = ${HOME}
(Get-PSProvider -PSProvider 'Environment').Home = ${HOME}


## Script variables go here
    # Check for Administrator elevation
Set-Variable -Name UserInfo -Value $([System.Security.Principal.WindowsIdentity]::GetCurrent())  -Scope Private
Set-Variable -Name CheckGroup -Value $(New-Object -TypeName System.Security.Principal.WindowsPrincipal -ArgumentList (${UserInfo}))  -Scope Private
Set-Variable -Name AdminPrivCheck -Value $([System.Security.Principal.WindowsBuiltInRole]::Administrator) -Scope Private
Set-Variable -Name AdminPrivSet -Value $(${CheckGroup}.IsInRole(${AdminPrivCheck})) -Scope Private

## Aliases go here
    #~~~

## User modules to import go here

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
    Write-Host -Object ($((Get-Location).Path).Replace(${HOME},"~")) -NoNewLine -ForegroundColor Cyan

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
Set-Variable -Name Script_Dir -Value $(Join-Path -Path ${Profile_Directory} -ChildPath "Scripts") -Scope Private

Get-ChildItem -Path ${Script_Dir} | Where-Object {
    $_.Name -like "*.ps1"
} | ForEach-Object {
    . $_.FullName
}
