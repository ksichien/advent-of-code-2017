#!/usr/bin/env pwsh
function reallocate ([string]$memorybanks) {
    $configuration = $memorybanks.split() | foreach {invoke-expression $_} # convert string to int array
    $counter = 0
    $cfghashtable = @{}
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
        if ($cfghashtable.containsvalue($configuration -join ',')) { # break while loop when current configuration is found in cfghashtable
            $loop = $true
        }
    } while ($loop -ne $true)
    $counter
}

reallocate '0 2 7 0' # 5
reallocate (get-content './input.txt') # 5042
