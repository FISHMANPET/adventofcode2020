$instructions = get-content '8-sample.txt'
$instructions = get-content '8.txt'


$executed = @()

$line = 1
$value = 0

do {
    if ($executed -contains $line) {
        Write-Host "Value before duplicate is $value"
        break
    }
    $command, $amount = ($instructions[($line - 1)]).Split()
    $executed += $line
    switch ($command) {
        "acc" {
            $value += $amount
            $line++
        }
        "jmp" {
            $line += $amount
        }
        "nop" {
            $line++
        }
        Default {
            throw "invalid command on line $line $($instructions[($line - 1)])"
        }
    }

}
while ($true)
