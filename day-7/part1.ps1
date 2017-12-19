#!/usr/bin/env pwsh
function structure ([array]$towers) {
    $family = @{}
    foreach ($t in $towers) {
        $tower = $t.split(' (').split(')')
        $name = $tower[0] # extract the parents' key names  
        if ($t -like '*-> *') {
            $descendants = $t.split('-> ') # extract all the children's key names
            $family.add($name, $descendants[1].split(', '))  # put the parents (keys) and their children (array of values) inside of a hashtable
        }
    }
    $key = $family.getenumerator() | get-random -count 1 # retrieve random key/value pair from the hashtable
    findparent $family $key.key # traverse the hashtable recursively until the top parent (bottom tower) is found
}

function findparent ([hashtable]$family, [string]$key) {
    write-host "checking key $key"
    $hash = $family.GetEnumerator() | where-object {$_.value -contains $key} # check if the given key belongs to any of the parent keys in the hashtable
    if ($hash -ne $null) {
        write-host "key $key is not the bottom of the tower, switching to parent key" $hash.key
        findparent $family $hash.key # dig deeper into the hash table using the given key's parent key as input
    }
    else {
        write-host "bottom of tower found: $key"
    }
}

structure (get-content './example.txt') # tknk
structure (get-content './input.txt') # qibuqqg
