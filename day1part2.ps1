function captcha {
param([string]$sequence)
    $array1 = $sequence.split().tochararray() | foreach {invoke-expression $_} # convert string from file to int array
    $array2 = @()
    $half = $array1.length/2
    for ($i=0;$i -le $array1.length-1;$i++) {
        $iplushalf = if ($i -lt $half) {$i+$half} else {$i-$half} # determine whether to add or subtract half the array's length
        if ($array1[$i] -eq $array1[$iplushalf]) {
            $array2 += $array1[$i]
        }
    }
    $array2 | measure -sum | select -expand sum # sum all elements inside the array
}

captcha 1212 # 6
captcha 1221 # 0
captcha 123425 # 4
captcha 123123 # 12
captcha 12131415 # 4
captcha (Get-Content './day1.txt')
