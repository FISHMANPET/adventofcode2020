$originstructions = get-content '8-sample.txt'
$originstructions = get-content '8.txt'






:labelOuter for ($i = 1; $i -lt $originstructions.Count + 1; $i++) {
    $instructions = $originstructions.Clone()
    $changecommand, $changeamount = $instructions[$i - 1].Split()
    switch ($changecommand) {
        "acc" {
            continue
        }
        "jmp" {
            $instructions[$i -1] = "nop $changeamount"
        }
        "nop" {
            $instructions[$i -1] = "jmp $changeamount"
        }
        Default {
            throw "invalid command on line $i $($instructions[($i - 1)])"
        }
    }

    $executed = @()

    $line = 1
    $value = 0
    do {
        if ($executed -contains $line) {
            Write-Host "Value before duplicate is $value"
            break
        }
        if ($line -eq ($instructions.Count + 1)) {
            Write-Host "Value before exiting is $value"
            break Outer
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
}
