#!/usr/bin/env pwsh
function captcha ([string]$sequence) {
    $array1 = $sequence.split().tochararray() | foreach {invoke-expression $_} # convert string to int array
    $array2 = New-Object System.Collections.ArrayList
    if ($array1[0] -eq $array1[-1]) {
        $array2.add($array1[0]) | out-null
    }
    for ($i=0;$i -le $array1.length-1;$i++) {
        if ($array1[$i] -eq $array1[$i+1]) {
            $array2.add($array1[$i]) | out-null
        }
    }
    $array2 | measure -sum | select -expand sum # sum all elements inside the array
}

captcha '1122' # 3
captcha '1111' # 4
captcha '1234' # 0
captcha '91212129' # 9
captcha (get-content './input.txt') # 1175
