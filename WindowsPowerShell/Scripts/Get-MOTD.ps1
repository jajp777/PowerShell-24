function Get-MOTD {

function Get-Uptime {
   $os = Get-WmiObject win32_operatingsystem
   $uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
   $Display = "" + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes"
   Write-Output $Display
}

function Get-CPUName {
   (Get-WmiObject Win32_Processor).Name -replace '\(C\)', '' -replace '\(R\)', '' -replace '\(TM\)', '' -replace 'CPU', '' -replace '\s+', ' '
}

function Get-CPULoad {
   (Get-WmiObject win32_processor).LoadPercentage
}

function Get-TotalMemory {
   ([math]::round((Get-WmiObject -Class Win32_OperatingSystem).TotalVisibleMemorySize / 1024))
}

function Get-UsedMemory {
   ([math]::round((Get-WmiObject -Class Win32_OperatingSystem).TotalVisibleMemorySize / 1024)) - ([math]::round((Get-WmiObject -Class Win32_OperatingSystem).FreePhysicalMemory / 1024))
}

function Get-TotalDisk {
   ([math]::round((Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB))
}

function Get-UsedDisk {
   ([math]::round((Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB)) - ([math]::round((Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace / 1GB))
}

Write-Host ("")
Write-Host ("")
Write-Host ("         ,.=:^!^!t3Z3z.,                  ") -ForegroundColor Red
Write-Host ("        :tt:::tt333EE3                    ") -ForegroundColor Red
Write-Host ("        Et:::ztt33EEE ") -NoNewline -ForegroundColor Red
Write-Host (" @Ee.,      ..,     ") -NoNewline -ForegroundColor Green
Write-Host (Get-Date) -ForegroundColor Green
Write-Host ("       ;tt:::tt333EE7") -NoNewline -ForegroundColor Red
Write-Host (" ;EEEEEEttttt33#     ") -ForegroundColor Green
Write-Host ("      :Et:::zt333EEQ.") -NoNewline -ForegroundColor Red
Write-Host (" SEEEEEttttt33QL     ") -NoNewline -ForegroundColor Green
Write-Host ("User: ") -NoNewline -ForegroundColor Red
Write-Host ("$env:username") -ForegroundColor Cyan
Write-Host ("      it::::tt333EEF") -NoNewline -ForegroundColor Red
Write-Host (" @EEEEEEttttt33F      ") -NoNewline -ForeGroundColor Green
Write-Host ("Hostname: ") -NoNewline -ForegroundColor Red
Write-Host ("$env:computername") -ForegroundColor Cyan
Write-Host ("     ;3=*^``````'*4EEV") -NoNewline -ForegroundColor Red
Write-Host (" :EEEEEEttttt33@.      ") -NoNewline -ForegroundColor Green
Write-Host ("OS: ") -NoNewline -ForegroundColor Red
Write-Host ((Get-WmiObject -class Win32_OperatingSystem).Caption) -ForegroundColor Cyan
Write-Host ("     ,.=::::it=., ") -NoNewline -ForegroundColor Cyan
Write-Host ("``") -NoNewline -ForegroundColor Red
Write-Host (" @EEEEEEtttz33QF       ") -NoNewline -ForegroundColor Green
Write-Host ("Kernel: ") -NoNewline -ForegroundColor Red
Write-Host ("NT ") -NoNewline -ForegroundColor Cyan
Write-Host ((Get-WmiObject -class Win32_OperatingSystem).Version) -ForegroundColor Cyan
Write-Host ("    ;::::::::zt33) ") -NoNewline -ForegroundColor Cyan
Write-Host ("  '4EEEtttji3P*        ") -NoNewline -ForegroundColor Green
Write-Host ("Uptime: ") -NoNewline -ForegroundColor Red
Write-Host (Get-Uptime) -ForegroundColor Cyan
Write-Host ("   :t::::::::tt33.") -NoNewline -ForegroundColor Cyan
Write-Host (":Z3z.. ") -NoNewline -ForegroundColor Yellow
Write-Host (" ````") -NoNewline -ForegroundColor Green
Write-Host (" ,..g.        ") -NoNewline -ForegroundColor Yellow
Write-Host ("Shell: ") -NoNewline -ForegroundColor Red
Write-Host ("Powershell ") -NoNewline -ForegroundColor Cyan
Write-Host ((Get-Host).Version.Major) -ForegroundColor Cyan
Write-Host ("   i::::::::zt33F") -NoNewline -ForegroundColor Cyan
Write-Host (" AEEEtttt::::ztF         ") -NoNewline -ForegroundColor Yellow
Write-Host ("CPU: ") -NoNewline -ForegroundColor Red
Write-Host (Get-CPUName) -ForegroundColor Cyan
Write-Host ("  ;:::::::::t33V") -NoNewline -ForegroundColor Cyan
Write-Host (" ;EEEttttt::::t3          ") -NoNewline -ForegroundColor Yellow
Write-Host ("Processes: ") -NoNewline -ForegroundColor Red
Write-Host ((Get-Process).Count) -ForegroundColor Cyan
Write-Host ("  E::::::::zt33L") -NoNewline -ForegroundColor Cyan
Write-Host (" @EEEtttt::::z3F          ") -NoNewline -ForegroundColor Yellow
Write-Host ("Current Load: ") -NoNewline -ForegroundColor Red
Write-Host (Get-CPULoad) -NoNewline -ForegroundColor Cyan
Write-Host ("%") -ForegroundColor Cyan
Write-Host (" {3=*^``````'*4E3)") -NoNewline -ForegroundColor Cyan
Write-Host (" ;EEEtttt:::::tZ``          ") -NoNewline -ForegroundColor Yellow
Write-Host ("Memory: ") -NoNewline -ForegroundColor Red
Write-Host (Get-UsedMemory) -NoNewline -ForegroundColor Cyan
Write-Host ("mb/") -NoNewline -ForegroundColor Cyan
Write-Host (Get-TotalMemory) -NoNewline -ForegroundColor Cyan
Write-Host ("mb Used") -ForegroundColor Cyan
Write-Host ("             ``") -NoNewline -ForegroundColor Cyan
Write-Host (" :EEEEtttt::::z7            ") -NoNewline -ForegroundColor Yellow
Write-Host ("Disk: ") -NoNewline -ForegroundColor Red
Write-Host (Get-UsedDisk) -NoNewline -ForegroundColor Cyan
Write-Host ("gb/") -NoNewline -ForegroundColor Cyan
Write-Host (Get-TotalDisk) -NoNewline -ForegroundColor Cyan
Write-Host ("gb Used") -ForegroundColor Cyan
Write-Host ("                 'VEzjt:;;z>*``           ") -ForegroundColor Yellow
Write-Host ("                      ````                  ") -ForegroundColor Yellow
Write-Host ("")

}
