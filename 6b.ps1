$raw = get-content -Raw '6-sample.txt'
$raw = get-content -Raw '6.txt'
$groups = $raw.Trim() -Split "`r`n`r`n"

$sum = 0
foreach ($group in $groups) {
    [char[][]]$answers = $group -split "`r`n"
    $same = 0
    if ($answers.Length -eq 1) {
        $same = $answers[0].Length
    } else {
        foreach ($char in $answers[0]) {
            $match = $true
            foreach ($answer in $answers[1..($answers.Length - 1)]) {
                if ($answer -notcontains $char) {
                    $match = $false
                }
            }
            $same += [int]$match
        }
    }
    #Write-Output "$same"
    $sum += $same
}
Write-Output $sum
