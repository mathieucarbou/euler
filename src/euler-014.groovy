def collatz, nbTerms = [1L: 1]
collatz = {nbTerms[it] ?: (nbTerms[it] = 1 + collatz(it & 0x1 ? 3 * it + 1 : it >> 1)) }
for (N in 999999L..2L) collatz(N)
println(nbTerms.max {it.value}.key)
