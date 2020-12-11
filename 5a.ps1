
$passes = 'FBFBBFFRLR', 'BFFFBBFRRR', 'FFFBBBFRRR', 'BBFFBBFRLL'
$passes = get-content '5.txt'

$maxId = 0
$depth = 0..127
$width = 0..7
function Find-Row ($range, $row) {
    $front = $range[0]..($range[($range.Length / 2) - 1])
    $back = ($range[$range.Length / 2])..$range[-1]
    if ($row[0] -eq 'F') {
        if ($front.Length -eq 1) {
            return $front[0]
        } else {
            return Find-Row -range $front -row $row[1..($row.Length - 1)]

        }
    } elseif ($row[0] -eq 'B') {
        if ($back.Length -eq 1) {
            return $back[0]
        } else {
            return Find-Row -range $back -row $row[1..($row.Length - 1)]

        }
    }
}

function Find-Column ($range, $column) {
    $left = $range[0]..($range[($range.Length / 2) - 1])
    $right = ($range[$range.Length / 2])..$range[-1]
    if ($column[0] -eq 'L') {
        if ($left.Length -eq 1) {
            return $left[0]
        } else {
            return Find-Column -range $left -column $column[1..($column.Length - 1)]

        }
    } elseif ($column[0] -eq 'R') {
        if ($right.Length -eq 1) {
            return $right[0]
        } else {
            return Find-Column -range $right -column $column[1..($column.Length - 1)]

        }
    }
}

foreach ($line in $passes) {
    $row = ($line | Select-String -Pattern '^[BF]*').Matches.Value
    $column = ($line | Select-String -Pattern '[LR]*$').Matches.Value
    $rownum = Find-Row -range $depth -row $row
    $colnum = Find-Column -range $width -column $column
    $id = ($rownum * 8) + $colnum
    #Write-Output "$line`: row $rownum, column $colnum, seat ID $id"
    if ($id -gt $maxId) {
        $maxId = $id
    }
}

Write-Output $maxId
