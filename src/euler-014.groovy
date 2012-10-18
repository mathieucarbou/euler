def collatz, nbTerms = [1L: 1]
collatz = {nbTerms[it] ?: (nbTerms[it] = 1 + collatz(it & 0x1 ? (it + (it << 1) + 1L) : (it >> 1)))}
for (N in 999999L..2L) collatz(N)
println(nbTerms.max {it.value}.key)
