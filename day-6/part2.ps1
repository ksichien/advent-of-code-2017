#!/usr/bin/env pwsh
function reallocate ([string]$memorybanks) {
    $configuration = $memorybanks.split() | foreach {invoke-expression $_} # convert string to int array
    $counter = 0
    $loopcounter = 0
    $cfghashtable = @{}
    $loophashtable = @{}
    do {
        $cfghashtable[$counter++] = $configuration -join ',' # add the current counter (key) and configuration (value) into the hash table
        [int]$operations = ($configuration | measure -maximum).maximum # find the highest number in configuration, this is equal to the redistribution operations
        $index = $configuration.IndexOf($operations) # find the index of the highest number
        $configuration[$index] = 0 # set the value to 0
        do {
            if ($index -eq ($configuration.length-1)) {$index = 0} else {$index++} # from the tail of the array, loop back to the head
            $configuration[$index]++
            $operations--
        } while ($operations -ne 0)
        if ($loophashtable.containsvalue($configuration -join ',')) {$loop = $true}  # the first time current configuration is found in loophashtable, break while loop
        if ($cfghashtable.containsvalue($configuration -join ',')) {
            $loopcounter++
            if ($loopcounter -eq 1) {
                $loophashtable[$loopcounter] = $configuration -join ',' # the first time current configuration is found in cfghashtable, add it to loophashtable
            }
        }
    } while ($loop -ne $true)
    write-host ($loopcounter - 1) # to account for the extra addition from the second if statement
}

reallocate '0 2 7 0' # 4
reallocate (get-content './input.txt') # 1086
