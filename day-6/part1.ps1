#!/usr/bin/env pwsh
function reallocate ([string]$memorybanks) {
    $configuration = $memorybanks.split() | foreach {invoke-expression $_} # convert string to int array
    $counter = 0
    $cfgarraylist = @{}
    do {
        $cfgarraylist[$counter++] = $configuration -join ',' # add the current state of configuration into the hash table as value with the current counter key
        [int]$operations = ($configuration | measure -maximum).maximum # find highest number in the current configuration
        $index = $configuration.IndexOf($operations) # find the index of the highest number
        $configuration[$index] = 0 # set the value to 0
        do {
            if ($index -eq ($configuration.length-1)) {$index = 0} else {$index++}
            $configuration[$index]++
            $operations--
        } while ($operations -ne 0)
        if ($cfgarraylist.containsvalue($configuration -join ',')) {
            $loop = $true
        }
    } while ($loop -ne $true)
    $counter
}

reallocate '0 2 7 0' # 5
reallocate (get-content './input.txt') # 5042
