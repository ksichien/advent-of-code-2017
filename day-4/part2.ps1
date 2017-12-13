#!/usr/bin/env pwsh
function passphrase ([array]$phrase) {
    $validation = New-Object System.Collections.ArrayList
    foreach ($line in $phrase) {
        $passwords = $line.split() # split the line into an array of passwords
        $sortedpasswords = New-Object System.Collections.ArrayList
        foreach ($password in $passwords) {
            $sortedpassword = $password.tochararray() | sort-object # split the password into a char array and sort all letters alphabetically
            $ofs = "" # this variable controls what criteria to use for converting an array to a string
            $sortedpasswords.add([string]$sortedpassword) | out-null
        }
        $uniquepasswords = $sortedpasswords | sort-object -uniq # sort the array and remove all duplicates
        $compare = compare-object $sortedpasswords $uniquepasswords # compare both arrays, if they are equal $null is returned
        if ($compare -eq $null) {
            $validation.add($passwords) | out-null
        }
    }
    $validation.count # print the number of valid passphrases
}

passphrase 'abcde fghij' # valid
passphrase 'abcde xyz ecdab' # not valid - the letters from the third word can be rearranged to form the first word.
passphrase 'a ab abc abd abf abj' # valid - all letters need to be used when forming another word.
passphrase 'iiii oiii ooii oooi oooo' # valid
passphrase 'oiii ioii iioi iiio' # not valid - any of these words can be rearranged to form any other word.
passphrase (get-content './input.txt') # 186 valid
