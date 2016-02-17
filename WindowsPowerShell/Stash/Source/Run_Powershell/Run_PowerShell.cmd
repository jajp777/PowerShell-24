@echo off
setlocal
goto :variable_block

:: Microsoft Windows Batch Script
::
:: Name: Run PowerShell Portable
:: Version: 0.6
:: Author: Michal Millar
:: https://github.com/michalmillar
:: http://www.bolis.com
::
:: Binary made with Bat2Exe
:: http://www.f2ko.de/en/b2e.php
::
:: Description:
:: Run PowerShell with settings localized into the current directory.
:: This script will start a custom PowerShell shortcut located in the Settings
:: directory. That shortcut will start PowerShell and inherit it's profile
:: from the current WindowsPowerShell directory.
::
:: This script, compiled or not, is intended to be located in the same
:: directory as the powershell profile. It also expects the shortcuts to reside
:: in a subdirectory named "Settings."
::
:: Enjoy!
::

:: Declare variables we will use throughout the script.
:variable_block
    set script_directory=%~dp0
    pushd %script_directory%
    set powershell_lnk=

    goto :main

:: This function checks the contents of an environment variable to determine 
:: the running system's architecture. This will set which version of the
:: program will be run.
:set_arch_type
    if "%PROCESSOR_ARCHITECTURE%" == "x86" (
        if not defined %PROCESSOR_ARCHITEW6432% ( ^
            set powershell_lnk=PowerShell_x86.lnk ^
        ) else set powershell_lnk=PowerShell_x64.lnk
    )
    exit /b %ERRORLEVEL%

:: The script can be exited cleanly by jumping to this function which will both
:: unset the scope, and end the script's process without ending the parent
:: process. It will also pass along the exit code (error level) to the parent.
:quit_prog
    endlocal
    exit /b %ERRORLEVEL%

:: This is the main function which calls all other functions in the script.
:: Unlike most other scripting languages, in Batch all functions are
:: programmatically expanded. As such, the main function should be topmost
:: and call whatever functions it needs to. It should close by ending the 
:: program.
:main
    :: Unlike the `goto` statement, using `call` to jump to a function will
    :: return to this line and continue, once said function has completed.
    call :set_arch_type

    if exist Settings (
        pushd Settings

        if exist %powershell_lnk% (
            start %powershell_lnk%
        )
        popd
    )
    goto :quit_prog
