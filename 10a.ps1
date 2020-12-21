[int[]]$adapters = get-content '.\10-sample1.txt'
[int[]]$adapters = get-content '.\10-sample2.txt'
[int[]]$adapters = get-content '.\10.txt'

$sorted = $adapters | Sort-Object

$joltage = 0

$jump1 = 0
$jump2 = 0
$jump3 = 0

for ($i = 0; $i -lt $sorted.Count; $i++) {
    $jjump = $sorted[$i] - $joltage
    switch ($jjump) {
        1 {$jump1++}
        2 {$jump2++}
        3 {$jump3++}
        Default {}
    }
    $joltage += $jjump
}

$jump3++

Write-Host "jump1 $jump1 jump3 $jump3 $($jump1*$jump3)"
