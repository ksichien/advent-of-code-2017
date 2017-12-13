#!/usr/bin/env pwsh
function jump ([array]$instructions) {
    $counter = 0
    $currentpos = 0
    do {
        $counter++
        [int]$currentval = $instructions[$currentpos]
        $nextpos = $currentpos + $currentval
        $instructions[$currentpos] = $currentval+1
        $currentpos = $nextpos
    } while ($currentpos -lt ($instructions.length))
    $counter
}

jump @(0,3,0,1,-3) # 5
jump (get-content './input.txt') # 378980
