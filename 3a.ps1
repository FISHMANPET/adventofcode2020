$map = get-content '3.txt'

$trees = 0
$position = 0
$mapwidth = $map[0].Length
foreach ($row in $map) {
    if ($row[$position%$mapwidth] -eq '#') {
        $trees++
    }
    $position += 3
}

Write-Host "$trees trees hit"
