[int[]]$data = get-content '9-sample.txt'
$plength = 5

[long[]]$data = get-content '9.txt'
$plength = 25

for ($i = $plength; $i -lt ($data.Count-1); $i++) {
    $preamble = $data[($i - $plength)..($i-1)]
    $preamblesums = @()
    for ($j = 0; $j -lt $preamble.Count; $j++) {
        for ($k = 0; $k -lt $preamble.Count; $k++) {
            if ($j -eq $k) {continue}
            $preamblesums += ($preamble[$j] + $preamble[$k])
        }
    }
    if ($preamblesums -notcontains $data[$i]) {
        Write-Host "$($data[$i]) is corrupted"
        break
    }
}
