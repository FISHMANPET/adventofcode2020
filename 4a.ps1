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
    if (
        $passport.keys -contains 'byr' -and
        $passport.keys -contains 'iyr' -and
        $passport.keys -contains 'eyr' -and
        $passport.keys -contains 'hgt' -and
        $passport.keys -contains 'hcl' -and
        $passport.keys -contains 'ecl' -and
        $passport.keys -contains 'pid'
    ) {
        $valid++
    }
}

Write-Host "$valid valid passports"
