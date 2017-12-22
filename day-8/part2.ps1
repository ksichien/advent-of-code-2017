#!/usr/bin/env pwsh
function register ([array]$instructions) {
    $variables = @{}
    [int]$highest = 0
    foreach ($instruction in $instructions) {
        $lines = $instruction.split(' if ')
        $operation = $lines[0].split()
        $comparison = $lines[1].split()
        
        $variables.item($comparison[0]) = [int]$variables.item($comparison[0]) # convert to integer
        $comparison[2] = [int]$comparison[2] # convert to integer
        $variables[$operation[0]] = [int]$variables[$operation[0]] # convert to integer
        $operation[2] = [int]$operation[2] # convert to integer

        switch ($comparison[1]) {
            '<' {
                if ($variables.item($comparison[0]) -lt $comparison[2]) {
                    calculate $variables $operation
                }
            }
            '<=' {
                if ($variables.item($comparison[0]) -le $comparison[2]) {
                    calculate $variables $operation
                }
            }
            '==' {
                if ($variables.item($comparison[0]) -eq $comparison[2]) {
                    calculate $variables $operation
                }
            }
            '!=' {
                if ($variables.item($comparison[0]) -ne $comparison[2]) {
                    calculate $variables $operation
                }
            }
            '>' {
                if ($variables.item($comparison[0]) -gt $comparison[2]) {
                    calculate $variables $operation
                }
            }
            '>=' {
                if ($variables.item($comparison[0]) -ge $comparison[2]) {
                    calculate $variables $operation
                }
            }
        }
        if ($variables[$operation[0]] -gt $highest) {
            $highest = $variables[$operation[0]]
        }
    }
    $highest
}

function calculate ([hashtable]$variables, [array]$operation) {
    if ($operation[1] -eq 'inc') {
        $variables[$operation[0]] += $operation[2]
    }
    elseif ($operation[1] -eq 'dec') {
        $variables[$operation[0]] -= $operation[2]
    }
}

register (get-content './example.txt') # 10
register (get-content './input.txt') # 6209
