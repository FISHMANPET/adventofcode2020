$raw = get-content -Raw '6-sample.txt'
$raw = get-content -Raw '6.txt'
$groups = $raw -Split "`r`n`r`n"

$sum = 0
foreach ($group in $groups) {
    $answers = (([char[]]($group -replace "`r`n", "")) | Select-Object -Unique).count
    $sum += $answers
}
Write-Output $sum
