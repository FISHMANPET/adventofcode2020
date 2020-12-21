$ErrorActionPreference = 'Stop'
[char[][]]$seats = get-content '11-sample.txt'
[char[][]]$seats = get-content '11.txt'

function deep-clone-seats ($seats) {
    $cloned = [System.Collections.ArrayList]@()
    foreach ($row in $seats) {
        [void]$cloned.Add($row.Clone())
    }
    return [char[][]]$cloned

}
$iterations = 0
$newseats = deep-clone-seats $seats
do {
    $iterations++
    $changed = $false
    $nextseats = deep-clone-seats $newseats
    for ($row = 0; $row -lt $seats.Count; $row++) {
        for ($col = 0; $col -lt $seats[0].Count; $col++) {
            #Write-Host "row $row col $col"
            if ($newseats[$row][$col] -in 'L', '#') {
                if (($row -eq 0) -and ($col -eq 0)) {
                    #case 1
                    $near = $newseats[0][1] +
                    $newseats[1][0] +
                    $newseats[1][1]
                    if ($near.Length -ne 3) {throw "$row $col error"}
                } elseif (($row -eq ($seats.Count - 1)) -and ($col -eq ($seats[0].count - 1))) {
                    #case 9
                    #Write-Host "case 9"
                    $near = $newseats[$row - 1][$col - 1] +
                    $newseats[$row - 1][$col] +
                    $newseats[$row][$col - 1]
                    if ($near.Length -ne 3) {throw "$row $col error"}
                } elseif ($row -eq 0) {
                    #case 3
                    $near = $newseats[0][$col - 1] +
                    $newseats[1][$col - 1] +
                    $newseats[1][$col]
                    if ($col -ne ($seats[0].count - 1)) {
                        #case 2
                        $near += $newseats[0][$col + 1] +
                        $newseats[1][$col + 1]
                    }
                } elseif ($col -eq 0) {
                    #case 7
                    $near = $newseats[$row - 1][0] +
                    $newseats[$row - 1][1] +
                    $newseats[$row][1]
                    if ($row -ne ($seats.Count - 1)) {
                        #case 4
                        $near += $newseats[$row + 1][0] +
                        $newseats[$row + 1][1]
                    }
                } else {
                    #case 9 again
                    #Write-Host "case 9 again"
                    $near = $newseats[$row - 1][$col - 1] +
                    $newseats[$row - 1][$col] +
                    $newseats[$row][$col - 1]
                    if (($col -ne ($seats[0].count - 1)) -and ($row -ne ($seats.Count - 1))) {

                        $near += $newseats[$row - 1][$col + 1] +
                        $newseats[$row][$col + 1] +
                        $newseats[$row + 1][$col - 1] +
                        $newseats[$row + 1][$col] +
                        $newseats[$row + 1][$col + 1]
                    } elseif ($row -ne ($seats.Count - 1)) {
                        $near += $newseats[$row + 1][$col - 1] +
                        $newseats[$row + 1][$col]
                    } elseif ($col -ne ($seats[0].count - 1)) {
                        $near += $newseats[$row - 1][$col + 1] +
                        $newseats[$row][$col + 1]
                    } else {
                        throw "case overflow"
                    }
                }
                $seatstaken = ([char[]]$near | Where-Object {$_ -eq '#'} | Measure-Object).Count
                if (($newseats[$row][$col] -eq 'L') -and ($seatstaken -eq 0)) {
                    $nextseats[$row][$col] = [char]'#'
                    $changed = $true
                } elseif (($newseats[$row][$col] -eq '#') -and ($seatstaken -ge 4)) {
                    $nextseats[$row][$col] = [char]'L'
                    $changed = $true
                }
            }
        }
    }
    $newseats = deep-clone-seats $nextseats

    Write-Host "$iterations iterations"

} while ($changed)

$totalseats = 0
foreach ($row in $newseats) {
    $totalseats += ($row | Where-Object {$_ -eq '#'} | Measure-Object).Count
}
