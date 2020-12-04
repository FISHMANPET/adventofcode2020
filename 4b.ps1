$raw = get-content -Raw '4.txt'
$split = $raw -Split "`r`n`r`n"
$again = $split | ForEach-Object {
    $temp = $_.split(" `r`n", [StringSplitOptions]::RemoveEmptyEntries)
    $hash = @{}
    foreach ($item in $temp) {
        $key, $value = $item.split(":")
        $hash[$key] = $value
    }
    return $hash
}
$valid = 0
foreach ($passport in $again) {
    if ($passport.keys -contains 'byr' -and
        $passport.byr -ge 1920 -and
        $passport.byr -le 2002) {
        if ($passport.Keys -contains 'iyr' -and
            $passport.iyr -ge 2010 -and
            $passport.iyr -le 2020) {
            if ($passport.Keys -contains 'eyr' -and
                $passport.eyr -ge 2020 -and
                $passport.eyr -le 2030) {
                if ($passport.keys -contains 'hgt' -and
                    $passport.hgt.Length -ge 2 -and
                    ($unit = $passport.hgt.Substring($passport.hgt.Length - 2, 2)) -in 'cm', 'in' -and
                    ($hgtval = $passport.hgt.Substring(0, $passport.hgt.Length - 2)) -match '^\d+$' -and
                    (($unit -eq 'cm' -and $hgtval -ge 150 -and $hgtval -le 193) -or ($unit -eq 'in' -and $hgtval -ge 59 -and $hgtval -le 76))) {
                    if ($passport.keys -contains 'hcl' -and
                        $passport.hcl.Length -eq 7 -and
                        $passport.hcl[0] -eq '#' -and
                        $passport.hcl.Substring(1, 6) -match '^[\da-fA-F]+$') {
                        if ($passport.keys -contains 'ecl' -and
                            $passport.ecl -in 'amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth') {
                            if ($passport.keys -contains 'pid' -and
                            $passport.pid.Length -eq 9 -and
                            $passport.pid -match '^\d+$') {
                                $valid++
                            }
                        }
                    }
                }
            }
        }
    }
}
Write-Host "$valid valid passports"
