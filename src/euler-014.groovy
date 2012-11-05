/*
    http://oeis.org/A006877
    => we start from n=837799
    => we skip all multiples of 2 because n/2 would no produce a longer sequence than 837799
*/
Map<Long, Integer> nbTerms = [(1L): 1]
for (long n = 837799L; n <= 999999L; n += 2) {
    int nb = 1
    long i = 3 * n + 1
    while (!nbTerms[i]) {
        while ((i & 1) == 0) {
            i = i >> 1
            nb++
        }
        if (nbTerms[i]) {
            nb += nbTerms[i]
        } else {
            i = 3 * i + 1
            nb++
        }
    }
    nbTerms.put(n, nb)
}
println(nbTerms.max {it.value}.key)
