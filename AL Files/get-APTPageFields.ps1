<#
.SYNOPSIS
    Get all fields of the page
.DESCRIPTION
    Get all fields of the page incl. the properties
.EXAMPLE
    get-APTPageFields -ALPageObjectFilePath "src\Timesheet\TimesheetProject.Page.al"
#>
function get-APTPageFields {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ALPageObjectFilePath
    )
    
    process {        
        $ALPageObjectFilePath;

        
        [string]$FileContent = Get-Content -Path $ALPageObjectFilePath -encoding UTF8 -Raw
        # Write-Host "File Content: $($FileContent)";

        #parts and fields
        # example https://regex101.com/r/tWzycm/7
        #$regex = '(\w+)\((.*)(;\s)(.*)\).*\n.*(\{[^}]+\})'
        #only fields
        # example https://regex101.com/r/tWzycm/9
        $regex = '(?i)field\((.*)(;\s)(.*)\).*\n.*(\{[^}]+\})'

        $MyMatches = @();

        $FileContent | Select-String $regex -AllMatches | ForEach-Object { 
            #write-host $_.Matches 
            $MyMatches += $_.Matches 
        } 
            
        Write-Output $MyMatches
    }
}