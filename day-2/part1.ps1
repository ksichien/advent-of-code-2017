#!/usr/bin/env pwsh
function checksum ([array]$spreadsheet) {
    $checksum =  New-Object System.Collections.ArrayList
    foreach($row in $spreadsheet) {
        $line = $row -replace '\s+', ',' # replace whitespace sections with commas to prepare for split
        foreach ($l in $line) {
            $array = $l.split(',') | foreach {invoke-expression $_} # convert string to int array
            $max = ($array | measure -maximum).maximum
            $min = ($array | measure -minimum).minimum
            $checksum.add($max - $min) | out-null # subtract the highest from the lowest number in the array
        }
    }
    $checksum | measure -sum | select -expand sum # sum all elements inside the array
}

checksum @('5 1 9 5','7 5 3','2 4 6 8') # 18
checksum (get-content './input.txt') # 36174
