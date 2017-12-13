#!/usr/bin/env pwsh
function passphrase ([array]$phrase) {
    $validation = New-Object System.Collections.ArrayList
    foreach ($line in $phrase) {
        $passwords = $line.split() # split the line into an array of passwords
        $uniquepasswords = $passwords | sort-object -uniq # sort the array and remove all duplicates
        $compare = compare-object $passwords $uniquepasswords # compare both arrays, if they are equal $null is returned
        if ($compare -eq $null) {
            $validation.add($passwords) | out-null
        }
    }
    $validation.count # print the number of valid passphrases
}

passphrase 'aa bb cc dd ee' # valid
passphrase 'aa bb cc dd aa' # not valid
passphrase 'aa bb cc dd aaa' # valid
passphrase (get-content './input.txt') # 455 valid
