$instructions = get-content '12-sample.txt'
$instructions = get-content '12.txt'

$x = 0
$y = 0
$orient = 0

# E = 0
# S = 1
# W = 2
# N = 3

#$cardinal = 'E', 'S', 'W', 'N'

foreach ($inst in $instructions) {
    $action = $inst[0]
    [int]$value = $inst.Substring(1)
    #Write-Host "started at $x, $y facing $orient, executing $action for $value"
    switch ($action) {
        'N' {$x += $value}
        'S' {$x -= $value}
        'E' {$y += $value}
        'W' {$y -= $value}
        'L' {$orient = ($orient + (4 - ($value / 90))) % 4}
        'R' {$orient = ($orient + ($value / 90)) % 4}
        'F' {
            switch ($orient) {
                0 {$y += $value} # E
                1 {$x -= $value} # S
                2 {$y -= $value} # W
                3 {$x += $value} # N
            }
        }
        Default {}
    }
    #Write-Host "ending at $x, $y facing $orient"
}

$distance = [System.Math]::Abs($x) + [System.Math]::Abs($y)
Write-Host "Manhattan distance $distance"
