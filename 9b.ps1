[int[]]$data = get-content '9-sample.txt'
$target = 127
[long[]]$data = get-content '9.txt'
$target = 69316178

:labelOuter for ($i = 0; $i -lt ($data.Count); $i++) {
    $sum = 0
    $j = $i
    $values = @()
    do {
        $sum += $data[$j]
        $values += $data[$j]
        if ($sum -eq $target) {
            $minmax = $values | Measure-Object -Maximum -Minimum
            Write-Host "first is $($minmax.Minimum) $last is $($minmax.Maximum), sum is $($minmax.Minimum+$minmax.Maximum)"
            break Outer
        }
        $j++
    } while ($sum -lt $target)
}
