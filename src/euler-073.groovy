run('euler.groovy' as File)

int c = 0
for (int d = 5; d <= 12000; d++) {
    int m = (int) Math.ceil(d / 2 - 1)
    for (int n = (int) (d / 3 + 1); n <= m; n++)
        if (gcd(n, d) == 1) c++
}

println c
