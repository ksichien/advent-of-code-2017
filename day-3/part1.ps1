function spiral ([int]$data) {
    $rootofbound = [Math]::Ceiling([Math]::Sqrt($data)) # find the nearest higher perfect square root
    $bound = $rootofbound*$rootofbound # square the root to a number
    if ($rootofbound % 2 -eq 0 -and $bound -ne $data) {$stepsofbound = $rootofbound + 1} else {$stepsofbound = $rootofbound} # make sure the root is an uneven number
    $bound = $stepsofbound * $stepsofbound # square the result to a number
    $stepsofbound -= 1 # remove 1 from the root to find the manhattan distance

    # find the numbers in the corners of the spiral
    $bottomleftcorner = $bound - $stepsofbound
    $topleftcorner = $bottomleftcorner - $stepsofbound
    $toprightcorner = $topleftcorner - $stepsofbound
    $bottomrightcorner = $toprightcorner - ($stepsofbound-1) # 1 step less because otherwise the array's last element overlaps with the bound

    # generate arrays based on the corner numbers
    $bottomarray = $bottomleftcorner..$bound
    $leftarray = $topleftcorner..$bottomleftcorner
    $toparray = $toprightcorner..$topleftcorner
    $rightarray = $bottomrightcorner..$toprightcorner

    # calculate the steps based on which array the data is a member of
    if ($bottomarray -contains $data) { steps $bottomarray $data $stepsofbound }
    elseif ($leftarray -contains $data) { steps $leftarray $data $stepsofbound }
    elseif ($toparray -contains $data) { steps $toparray $data $stepsofbound }
    elseif ($rightarray -contains $data) { steps $rightarray $data $stepsofbound }
    else { "Something went wrong :(" }
}

function steps ([array]$array, [int]$data, [int]$stepsofbound) {
    if ($array.indexof($data) -ge $array.length/2) {
        $difference = ($array.length-1) - $array.indexof($data)
    }
    else {
        $difference = $array.indexof($data)
    }
    write-host ($stepsofbound - $difference)
}

spiral '1' # 0
spiral '12' # 3
spiral '23' # 2
spiral '1024' # 31
spiral (get-content './input.txt')
