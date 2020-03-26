<#
.SYNOPSIS
    Gets IDs of AL Object Files
.DESCRIPTION
    Loops trough directory and find IDs of the Objects
.EXAMPLE
    get-APTIDsOfALFiles -SourceFilePath "src"
.EXAMPLE
    get-APTIDsOfALFiles -SourceFilePath "src" | sort
#>
function get-APTIDsOfALFiles {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$SourceFilePath
    )

    begin {
    }

    process {
        $filter = "*.al"

        Write-Verbose "Filter files with '$($filter)'"

        Get-ChildItem $SourceFilePath -Filter $filter -Recurse | ForEach-Object {

            $CurrFile = $_;
            $regex = '(\w+)(\s[0-9]+\s(.)+)'
            
            ## TODO: Ginge sicher auch mit regex :)
            [string]$FileContent = Get-Content -Path $CurrFile.FullName -Raw 
            if (![string]::IsNullOrEmpty($FileContent)) {
                Write-Verbose "Object found: '$($CurrFile.FullName)'"
            }
            
            $FileContentObject = select-string -InputObject $FileContent -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } 
            if (![string]::IsNullOrEmpty($FileContentObject)) {
                Write-Verbose "Object ID found: '$($FileContentObject)'"
                Write-Verbose  "$($CurrFile.FullName)"
                Write-Verbose  "->$($FileContentObject)"

                Write-Output  $FileContentObject
            }
            
        }

    }

    end {
    }
}