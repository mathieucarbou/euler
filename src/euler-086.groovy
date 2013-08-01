run('euler.groovy' as File)
def (M, C) = [0, 0]
while (C < 1000000) {
    M++
    C = (2..2 * M).findAll { isPerfectSquare(M * M + it * it) }.inject C, { c, ab -> c + (ab > M + 1 ? M + M + 2 - ab : ab).intdiv(2) }
}
println M
