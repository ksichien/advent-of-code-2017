#!/usr/bin/env pwsh
function jump ([array]$instructions) {
    $counter = 0
    $currentpos = 0
    do {
        $counter++
        [int]$currentval = $instructions[$currentpos]
        $nextpos = $currentpos + $currentval
        if ($currentval -ge 3) {$instructions[$currentpos]=$currentval-1} else {$instructions[$currentpos]=$currentval+1}
        $currentpos = $nextpos
    } while ($currentpos -lt ($instructions.length))
    $instructions -join ","
    $counter
}

jump @(0,3,0,1,-3) # 10
jump (get-content './input.txt') # 26889114
