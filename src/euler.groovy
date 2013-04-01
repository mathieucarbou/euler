binding.variables << [
    gcd: { int x, int y ->
        if (x == 0) return y
        if (y == 0) return x
        int cf2 = Integer.numberOfTrailingZeros(x | y)
        x >>= Integer.numberOfTrailingZeros(x)
        while (true) {
            y >>= Integer.numberOfTrailingZeros(y)
            if (x == y) break
            if (x > y) {
                int t = x
                x = y
                y = t
            }
            if (x == 1) break
            y -= x
        }
        return x << cf2
    }
]
