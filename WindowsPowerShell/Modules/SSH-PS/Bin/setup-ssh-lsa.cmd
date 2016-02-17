if %PROCESSOR_ARCHITECTURE%==x86 (
   set lsadll=%~dp0x86\ssh-lsa.dll
)
if %PROCESSOR_ARCHITECTURE%==AMD64 (
   set lsadll=%~dp0x64\ssh-lsa.dll
)
copy %lsadll% %windir%\system32\
reg add HKLM\System\CurrentControlSet\Control\Lsa /v "Authentication Packages" /t REG_MULTI_SZ  /d  msv1_0\0ssh-lsa.dll -f
