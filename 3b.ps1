$map = get-content '3.txt'

$trees = @()
$mapwidth = $map[0].Length
$maplength = $map.Length
$scenarios = @(
    @{r = 1; d = 1}
    @{r = 3; d = 1}
    @{r = 5; d = 1}
    @{r = 7; d = 1}
    @{r = 1; d = 2}
)
foreach ($s in $scenarios) {
    $position = 0
    $localtrees = 0
    for ($i = 0; $i -lt $maplength; $i += $s.d) {
        if ($map[$i][$position % $mapwidth] -eq '#') {
            $localtrees++
        }
        $position += $s.r
    }
    $trees += $localtrees
}

$multiply = 1
foreach ($count in $trees) {
    $multiply = $multiply * $count
}

Write-Host "$multiply trees hit"
