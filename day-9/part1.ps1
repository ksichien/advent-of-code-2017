#!/usr/bin/env pwsh

function cleanup ([string]$stream) {
    $data = $stream.tochararray()
    $score = 0
    $depth = 0
    $ignore = $false
    $garbage = $false

    foreach ($char in $data) {
        if ($garbage) {
            if ($ignore) {
                $ignore = $false
                continue
            }
            switch ($char) {
                '!' { $ignore = $true; break }
                '>' { $garbage = $false; break }
            }
        }
        else {
            switch ($char) {
                '{' { $depth++; break }
                '<' { $garbage = $true; break }
                '}' { $score += $depth--; break }
            }
        }
    }
    $score
}

cleanup '{}' # 1
cleanup '{{{}}}' # 6
cleanup '{{},{}}' # 5
cleanup '{{{},{},{{}}}}' # 16
cleanup '{<a>,<a>,<a>,<a>}' # 1
cleanup '{{<ab>},{<ab>},{<ab>},{<ab>}}' # 9
cleanup '{{<!!>},{<!!>},{<!!>},{<!!>}}' # 9
cleanup '{{<a!>},{<a!>},{<a!>},{<ab>}}' # 3
cleanup (get-content './input.txt') # 8337
