$rules = get-content '7-sample.txt'
$rules = get-content '7.txt'

$cancontain = @{}

foreach ($rule in $rules) {
    [void]($rule -match '^(.*) bags contain (.*)\.$')
    $bag = $Matches[1]
    $contains = @(($Matches[2]).Split(',').Trim())
    $containsObj = $contains | ForEach-Object {
        $cont = $_
        if ($cont -match '^(\d+) ([\w\s]+) bags?$') {
            [pscustomobject]@{count = [int]$Matches[1]; type = $Matches[2]}
        }
    }
    $cancontain[$bag] = $containsObj
}

$target = 'shiny gold'
function Find-Container ($target, $foundSoFar) {
    $found = $false
    $localoptions = @()
    foreach ($key in $cancontain.Keys) {
        if ($cancontain[$key].type -contains $target) {
            $localoptions += $key
            $foundsofar += $key
            $found = $true
        }
    }
    if ($found) {
        foreach ($opt in $localoptions) {
            $funcreturn += Find-Container -target $opt -foundSoFar ($foundsofar | Select-Object -Unique)
            $foundsofar += $funcreturn
            write-host ($foundsofar | Select-Object -Unique).Count
        }
    }
    return $foundsofar | Select-Object -Unique

}

$myoptions = Find-Container -target $target -foundSoFar @()

write-host "$($myoptions.Count) bag options"
