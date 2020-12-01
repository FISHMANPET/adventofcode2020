[int[]]$expenses = get-content 1.txt

foreach ($inner in $expenses) {
    foreach ($outer in $expenses) {
        if (($inner + $outer) -eq 2020) {
            write-host "$inner $outer $($inner*$outer)"
            return
        }
    }
}
