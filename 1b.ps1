[int[]]$expenses = get-content 1.txt

foreach ($inner in $expenses) {
    foreach ($middle in $expenses) {
        foreach ($outer in $expenses) {
            if (($inner + $middle + $outer) -eq 2020) {
                write-host "$inner $middle $outer $($inner*$middle*$outer)"
                return
            }
        }
    }
}
