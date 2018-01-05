#!/usr/bin/env pwsh

function cleanup ([string]$stream) {
    $data = $stream.tochararray()
    $ignore = $false
    $garbage = $false
    $count = 0

    foreach ($char in $data) {
        if ($garbage) {
            if ($ignore) {
                $ignore = $false
                continue
            }
            switch ($char) {
                '!' { $ignore = $true; break }
                '>' { $garbage = $false; break }
                default { $count++; break }
            }
        }
        else {
            switch ($char) {
                '<' { $garbage = $true; break }
            }
        }
    }
    $count
}

cleanup '<>' # 0 
cleanup '<random characters>' # 17
cleanup '<<<<>' # 3
cleanup '<{!>}>' # 2
cleanup '<!!>' # 0
cleanup '<!!!>>' # 0
cleanup '<{o"i!a,<{i<a>' # 10
cleanup (get-content './input.txt') # 4330
