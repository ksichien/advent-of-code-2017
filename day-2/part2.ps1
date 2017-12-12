#!/usr/bin/env pwsh
function checksum ([array]$spreadsheet) {
    $checksum = New-Object System.Collections.ArrayList
    foreach($row in $spreadsheet) {
        $line = $row -replace '\s+', ','
        foreach ($l in $line) {
            $array = $l.split(',') | foreach {invoke-expression $_} # convert string to int array
            foreach ($a in $array) {
                $arraylist = {$array}.invoke() # convert array to arraylist
                $arraylist.remove($a) | out-null
                foreach ($b in $arraylist) {
                    if (($a % $b) -eq 0) {
                        $checksum.add($a / $b) | out-null
                    }
                }
            }
        }
    }
    $checksum | measure -sum | select -expand sum # sum all elements inside the array
}

checksum @('5 9 2 8','9 4 7 3','3 8 6 5') # 9
checksum (get-content './input.txt') # 244
