#!/usr/bin/env pwsh
function structure ([array]$towers) {
    $weights = @{}    
    $family = @{}
    foreach ($t in $towers) {
        $tower = $t.split(' (').split(')')
        $name = $tower[0] # extract the parents' key names
        $weight = $tower[1] # extract the parent keys' weight values
        $weights.add($name, $weight) # put the parents (key) and their weight (value) inside of a hashtable    
        if ($t -like '*-> *') {
            $descendants = $t.split('-> ') # extract all the children's key names
            $family.add($name, $descendants[1].split(', '))  # put the parents (keys) and their children (array of values) inside of a hashtable
        }
    }
    $key = $weights.getenumerator() | get-random -count 1
    $parent = findparent $family $key.key
    findweight $family $weights $parent
}

function findweight ([hashtable]$family, [hashtable]$weights, [string]$key) { # unfinished
    $children = $family.item($key)
    $array = new-object System.Collections.ArrayList
    foreach ($childkey in $children) {
        $sum = findsum $family $weights $childkey
        $array.add($sum) | out-null
    }
    write-host "the weight of $key is" $weights.item($key)
}

function findsum ([hashtable]$family, [hashtable]$weights, [string]$key) { # finds the sum for all children of the given key
    $values = $family.item($key)
    [int]$sum = $weights.item($key)
    foreach ($value in $values) {
        #$sum += ', '
        $sum += $weights.item($value)
    }
    write-host "the sum for" $key "and" ($values -join ',') "is" $sum
    $sum
}

function findparent ([hashtable]$family, [string]$key) { # finds the bottom of the tower's key
    $hash = $family.GetEnumerator() | where-object {$_.value -contains $key}
    if ($hash -ne $null) {
        findparent $family $hash.key
    }
    else {
        write-host "the bottom of the tower is $key"
        $key
    }
}

structure (get-content './example.txt') # ugml -> 60
structure (get-content './input.txt') # 
