Set-Alias cal Get-Calendar

function Get-Calendar {
<#
.SYNOPSIS
    
.DESCRIPTION
    
.EXAMPLE

#>

    param(
        [Parameter(Mandatory=$false,
            Position=0,
            ValueFromPipeline=$true)]
        [ValidateRange(1,12)]
        [Int32]$Month = (Get-Date -u %m),
    
        [Parameter(Mandatory=$false,
            Position=1,
            ValueFromPipeline=$true)]
        [ValidateScript({$_ -ge 2000})]
        [Int32]$Year = (Get-Date -u %Y)
    )
  
    begin {
        $arr = @()
        $cal = [Globalization.CultureInfo]::CurrentCulture.Calendar
        $dow = [Int32]$cal.GetDayOfWeek([DateTime]([String]$Month + ".1." + [String]$Year))
    }
    
	process {
        if ($dow -ne 0) {
            for ($i = 0; $i -lt $dow; $i++) {
                $arr += '  '
            }
        }
        
		1..$cal.GetDaysInMonth($Year, $Month) | % {
            if ($_.ToString().Length -eq "1") {
                $arr += ' ' + [String]$_
            }
            else {
                $arr += [String]$_
            }
        }
    }
    
	end {
        Write-Host Su Mo Tu We Th Fr Sa -for cyan
        for ($i = 0; $i -lt $arr.Length; $i+=6) {
            Write-Host $arr[$i..($i + 6)]
            $i++
        }
    Write-Host
    }
}