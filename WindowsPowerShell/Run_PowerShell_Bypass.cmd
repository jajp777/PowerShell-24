@echo off
setlocal
mode con: cols=80 lines=40
goto variable_block

:: Microsoft Windows Batch Script
::
:: Name: Run PowerShell Bypass
:: Version: 0.1
:: Author: Michal Millar
:: https://github.com/michalmillar
:: http://www.bolis.com
::
:: 

:variable_block
    set current_directory=%~dp0
    cd %current_directory%

    set powershell_args=-ExecutionPolicy Bypass -NoExit

:set_arch_type
    reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" ^
    | find /i "x86" > NUL && set arch_value=32 || set arch_value=64

    if %arch_value%==64 (
        set powershell_bin=%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe
    ) else if %arch_value%==32 (
        set powershell_bin=%systemroot%\SysWoW64\WindowsPowerShell\v1.0\powershell.exe
    ) else (
        echo. Error: Cant locate PowerShell.
        pause
        goto quit_prog
    )

:main
    %powershell_bin% %powershell_args%
    pause

:quit_prog
    endlocal
    exit
