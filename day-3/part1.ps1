#!/usr/bin/env pwsh
function spiral ([int]$data) {
    $rootofbound = [Math]::Ceiling([Math]::Sqrt($data)) # find the nearest perfect square root
    if ($rootofbound % 2 -eq 0) {$rootofbound += 1} # make sure the root is an uneven number
    $bound = $rootofbound * $rootofbound # square the root to find the boundary
    $stepsofbound = $rootofbound - 1 # subtract 1 from the root to find the manhattan distance

    # find the numbers in the corners of the spiral based on the boundary
    $bottomleftcorner = $bound - $stepsofbound
    $topleftcorner = $bottomleftcorner - $stepsofbound
    $toprightcorner = $topleftcorner - $stepsofbound
    $bottomrightcorner = $toprightcorner - ($stepsofbound-1) # the next number is the boundary of the previous chain

    # calculate the steps based on which two corners the data is between
    switch ($true) {
        ($data -in $bottomleftcorner..$bound) { steps @($bottomleftcorner..$bound) $data $stepsofbound; break }
        ($data -in $topleftcorner..$bottomleftcorner) { steps @($topleftcorner..$bottomleftcorner) $data $stepsofbound; break }
        ($data -in $toprightcorner..$topleftcorner) { steps @($toprightcorner..$topleftcorner) $data $stepsofbound; break }
        ($data -in $bottomrightcorner..$toprightcorner) { steps @($bottomrightcorner..$toprightcorner) $data $stepsofbound; break }
        default { "Something went wrong :(" }
    }
}

function steps ([array]$array, [int]$data, [int]$stepsofbound) { # determine which corner the data is closer to
    if ($array.indexof($data) -ge $array.length/2) { # if closer to the upper corner, subtract their indexes to find the difference
        $difference = ($array.length-1) - $array.indexof($data)
    }
    else { # if closer to the bottom corner, the data's index is equal to the difference
        $difference = $array.indexof($data)
    }
    write-host ($stepsofbound - $difference)
}

spiral '1' # 0
spiral '12' # 3
spiral '23' # 2
spiral '1024' # 31
spiral (get-content './input.txt') # 480
