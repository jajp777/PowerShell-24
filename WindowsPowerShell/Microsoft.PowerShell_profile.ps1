# My PowerShell Profile

# Modules to import go here

Import-Module Vim-PS
Import-Module OpenSSH-PS

# Script directory path
$scriptsdir = "$(split-path $myInvocation.MyCommand.Path)\Scripts"
#$env:path += ";$scriptsdir"

Get-ChildItem $scriptsdir | Where `
    { $_.Name -like "*.ps1"} | ForEach `
    { . $_.FullName }



# Aliases go here

# Functions and other gibblets here

# Make transcript of shell session

Write-Verbose ("[{0}] Initialize Transcript" -f (Get-Date).ToString()) -Verbose

If ($host.Name -eq "ConsoleHost") {
    $transcripts = (Join-Path $env:USERPROFILE "Documents\WindowsPowerShell\Transcripts")
    If (-Not (Test-Path $transcripts)) {
        New-Item -path $transcripts -Type Directory | Out-Null
    }
    $global:TRANSCRIPT = ("{0}\PSLOG_{1:dd-MM-yyyy}.txt" -f $transcripts,(Get-Date))
    Start-Transcript -Path $transcript -Append
    Get-ChildItem $transcripts | where {
        $_.LastWriteTime -lt (Get-Date).AddDays(-14)
    } | Remove-Item -Force -ea 0
}

Function Prompt {
    # Print the user and host:
    # Check for Administrator elevation
    $wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp=New-Object System.Security.Principal.WindowsPrincipal($wid)
    $adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
    $IsAdmin=$prp.IsInRole($adm)
    if ($IsAdmin) {
        Write-Host ("$env:username") -NoNewline -ForegroundColor Red
        Write-Host ("@") -NoNewline -ForegroundColor Red
        Write-Host ("$env:computername") -NoNewline -ForegroundColor Red
    }
    else {
        Write-Host ("$env:username") -NoNewline -ForegroundColor Green
        Write-Host ("@") -NoNewline -ForegroundColor Green
        Write-Host ("$env:computername") -NoNewline -ForegroundColor Green
    }
    # Print the working directory:
    Write-Host (":") -NoNewline -ForegroundColor Green
    Write-Host ($PWD) -NoNewline -ForegroundColor Cyan
    Write-Host (":") -NoNewline -ForegroundColor Cyan;
    # Check for Administrator elevation
    if ($IsAdmin) {
        Write-Host ("#") -NoNewline -ForegroundColor Red
        return " "
    }
    else {
        Write-Host ("$") -NoNewline -ForegroundColor White
        return " "
    }
}

# To edit the Powershell Profile

Function Edit-Profile {
    Vim $profile
}

# To edit Vim settings

Function Edit-Vimrc {
    Vim $HOME\_vimrc
}

# Changing some default shell values for style

$Shell = $Host.UI.RawUI
$Shell.WindowTitle=”PowerShell”
$size = $Shell.WindowSize
$size.width=80
$size.height=40
$Shell.WindowSize = $size
$size = $Shell.BufferSize
$size.width=80
$size.height=5000
$Shell.BufferSize = $size

Set-Location $HOME
Clear-Host
Get-MOTD | more
