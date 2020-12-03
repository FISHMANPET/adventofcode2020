$passwords = get-content '2.txt'

$correct = 0

foreach ($entry in $passwords) {
    $line = $entry.split()
    $min, $max = $line[0].split('-')
    $char = $line[1][0]
    $pw = $line[2]
    if ($pw[$min-1] -eq $char -xor $pw[$max-1] -eq $char) {
        $correct++
    }
}
Write-Host "$correct correct passwords"
