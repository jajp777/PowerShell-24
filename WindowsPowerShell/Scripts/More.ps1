Function Unix-More {
   <#
    .SYNOPSIS
        A Unix-like command for parsing output.

    .DESCRIPTION
    
    .EXAMPLE

   #>

   param(
     [Parameter(ValueFromPipeline=$true)]
     [System.Management.Automation.PSObject]$InputObject
   )

   begin
   {
      $type = [System.Management.Automation.CommandTypes]::Cmdlet
      $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(‘Out-Host’, $type)
      $scriptCmd = {& $wrappedCmd @PSBoundParameters -Paging }
      $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
      $steppablePipeline.Begin($PSCmdlet)
   }

   process
   {
      try
      {
         $steppablePipeline.Process($_)
      }
      catch
      {
        break;
      }
   }

   end
   {
      $steppablePipeline.End()
   }

   #.ForwardHelpTargetName Out-Host
   #.ForwardHelpCategory Cmdlet
}

New-Alias More Unix-More