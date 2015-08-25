<#
.SYNOPSIS
A set of functions for dealing with SSH connections from PowerShell, using portable OpenSSH for Windows.

See further information at:
http://www.vim.org/

Copyright (c) 2014, Michael Millar.
All rights reserved.
Author: Michael Millar

.DESCRIPTION
See:
Vim
#>

# Resolve full path to script directory

$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Begin Function block

<#
.SYNOPSIS
Vim is a text editor that is upwards compatible to Vi. It can be used to edit all kinds of plain text. It is especially useful for editing programs.

.DESCRIPTION
There are a lot of enhancements above Vi: multi level undo, multi windows and buffers, syntax highlighting, command line editing, filename completion, on-line help, visual selection,  etc.. See ":help vi_diff.txt" for a summary of the differences between Vim and Vi. While running Vim a lot of help can be obtained from the	on-line help system, with the ":help" command. Most often Vim is started to edit a single file with the command "vim [file]." More generally Vim is started with: "vim [options] [filelist]" If the filelist is missing, the editor will start with an empty buffer. Otherwise exactly one out of the following four may be used to choose one or more files to be edited.

.PARAMETER
#>
function Vim {
    Invoke-Expression "& $ScriptDir\vim\vim.exe $args"
}
New-Alias -Name Vi -value Vim
New-Alias -Name Edit-File -value Vim

######## END OF FUNCTIONS ########

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$global:Vim = @{}

Export-ModuleMember -Function Vim -Alias Vi, Edit-File