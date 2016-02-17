function New-ZipFile {
    #.Synopsis
    #  Create a new zip file, optionally appending to an existing zip...
    [CmdletBinding()]
    param(
    # The path of the zip to create
    [Parameter(Position=0, Mandatory=$true)]
    $ZipFilePath,
    
    # Items that we want to add to the ZipFile 
    # This will be a variable that contains the files to zip.  Not a string to recurse
    [Parameter(Position=1, Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias("PSPath","Item")]
    [array]$InputObject = $Pwd,
    
    # Append to an existing zip file, instead of overwriting it
    [Switch]$Append,
    
    # The compression level (defaults to Optimal):
    #   Optimal - The compression operation should be optimally compressed, even if the operation takes a longer time to complete.
    #   Fastest - The compression operation should complete as quickly as possible, even if the resulting file is not optimally compressed.
    #   NoCompression - No compression should be performed on the file.
    [System.IO.Compression.CompressionLevel]$Compression = "Optimal"
    )
    begin {
        # Make sure the folder already exists
        [string]$File = Split-Path $ZipFilePath -Leaf
        [string]$Folder = $(if($Folder = Split-Path $ZipFilePath) { Resolve-Path $Folder } else { $Pwd })
        $ZipFilePath = Join-Path $Folder $File
        # If they don't want to append, make sure the zip file doesn't already exist.
        if(!$Append) {
        if(Test-Path $ZipFilePath) { Remove-Item $ZipFilePath }
            }
        $Archive = [System.IO.Compression.ZipFile]::Open( $ZipFilePath, "Update" )
        $inputobject = $InputObject|?{$_.PSIsContainer -eq $false}
        }
    process {
        foreach($path in $InputObject) {
            foreach($item in Resolve-Path $path.fullname) {
                # Push-Location so we can use Resolve-Path -Relative
                Push-Location (Split-Path $item)
                # This will get the file, or all the files in the folder (recursively)
                
                # Calculate the relative file path
                $relative = ($path.fullname ).substring(3)
                # Add the file to the zip
                
                $null = [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($Archive, $path.fullname, $relative, $Compression)
                
                Pop-Location
                
                }
            }
        }
    end {
        $Archive.Dispose()
        Get-Item $ZipFilePath
        }
    }
