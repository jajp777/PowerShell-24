# Microsoft Windows Powershell Module Script
#
# Name: New-GUID
# Version: 0.0.0.1
# Author: Michal Millar
# https://github.com/michalmillar
# http://www.bolis.com
#
# License: 
# The BSD 3-Clause License
# Copyright (c) 2016, The Bolis Group
#
# Description:
# Provides single-command functionality to generate pseudo-random globally 
# unique identifiers.
#

# The Strictmode setting determines what coding rules will be enforced for the
# script's scope, and anything beneath it. The "Latest" setting ignores shell
# versions, opting for the best (most strict) practices.
Set-StrictMode -Version Latest

# Each function block intended to be exported as a command-object should have
# a block of synopsis information. This can then be used by `Get-Help` as the
# short-form basis for man-like help text.
<#
.SYNOPSIS
    Provides single-command functionality to generate pseudo-random globally unique identifiers.
.DESCRIPTION
    Provides single-command functionality to generate pseudo-random globally unique identifiers.
.PARAMETER
.EXAMPLE
.NOTES
    Author: Michal Millar
#>
Function New-GUID {
    [CmdletBinding()]
    Param(
#   	[Parameter(Mandatory=$True,
#		ValueFromPipeline=$True)]
#		[String[]]$Parameter_var_name 
    )
    Begin{} 
    Process{}
    End{
        [System.Guid]::NewGuid().toString()
    }
}

Export-ModuleMember -Function New-GUID
