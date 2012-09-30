/*

999 * 999 = 998001 (=> will be max. 6 digits)
100 * 100 = 10000  (=> will be min. 5 digits)

*/

def palindromes = []
for (i in 999..100) {
    for (j in i..100) {
        def n = (i * j) as String
        if (n == n.reverse())
            palindromes << i * j
    }
}
println palindromes.sort().reverse()
