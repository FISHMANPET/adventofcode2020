$rules = get-content '7-sample.txt'
$rules = get-content '7-sample2.txt'
$rules = get-content '7.txt'

$cancontain = @{}

foreach ($rule in $rules) {
    [void]($rule -match '^(.*) bags contain (.*)\.$')
    $bag = $Matches[1]
    $contains = @(($Matches[2]).Split(',').Trim())
    $containsObj = $contains | ForEach-Object {
        $cont = $_
        if ($cont -match '^(\d+) ([\w\s]+) bags?$') {
            [pscustomobject]@{counts = [int]$Matches[1]; type = $Matches[2]}
        }
    }
    $cancontain[$bag] = $containsObj
}

$target = 'shiny gold'

function Measure-Contains ($color) {
    if (-not $cancontain[$color]) {
        return 0
    } else {
        $sum = ($cancontain[$color].counts | Measure-Object -Sum).Sum
        foreach ($contain in $cancontain[$color]) {
            $sum += $contain.counts * (Measure-Contains -color $contain.type)
        }
    }
    return $sum
}

$bags = Measure-Contains -color $target

Write-Host "$bags bags"
