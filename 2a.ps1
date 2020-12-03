$passwords = get-content '2.txt'

$correct = 0

foreach ($entry in $passwords) {
    $line = $entry.split()
    $min, $max = $line[0].split('-')
    [char]$char = $line[1][0]
    $pw = $line[2]
    $count = ($pw.ToCharArray() | Where-Object {$_ -eq $char} | Measure-Object -Character).Characters
    if ($count -ge $min -and $count -le $max) {
        $correct++
    }
}
Write-Host "$correct correct passwords"
