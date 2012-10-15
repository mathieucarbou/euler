/*
    With all 9 digits:

        a * b = cdefghi => impossible
        ab * c = defghi => impossible
        ab * cd = efghi => impossible
        a * bcd = efghi => impossible

        a * bcde = fghi => possible (1)
        ab * cde = fghi => possible (2)

        a * bcdef = ghi => impossible
        a * bcdefg = hi => impossible
        a * bcdefgh = i => impossible

    (1)
        a * (1000*b + 100*c + 10*d + e) = 1000*f + 100*g + 10*h + i
        1000*(a*b-f) + 100*(a*c-g) + 10*(a*d-h) + (a*e-i) = 0

    (2)
        (10*a + b) * (100*c + 10*d + e) = 1000*f + 100*g + 10*h + i
        1000*a*c + 100*a*d + 10*a*e + 100*b*c + 10*b*d + b*e - 1000*f - 100*g - 10*h - i = 0
        1000*(a*c-f) + 100*(a*d+b*c-g) + 10*(a*e+b*d-h) + (b*e-i) = 0
*/

def prods = new TreeSet<Integer>()
def digits = 1..9
for (a in digits) {
    for (b in (digits - a)) {
        for (c in (digits - a - b)) {
            for (d in (digits - a - b - c)) {
                for (e in (digits - a - b - c - d)) {
                    for (f in (digits - a - b - c - d - e)) {
                        for (g in (digits - a - b - c - d - e - f)) {
                            for (h in (digits - a - b - c - d - e - f - g)) {
                                for (i in (digits - a - b - c - d - e - f - g - h)) {
                                    if (1000 * (a * b - f) + 100 * (a * c - g) + 10 * (a * d - h) + (a * e - i) == 0 || 1000 * (a * c - f) + 100 * (a * d + b * c - g) + 10 * (a * e + b * d - h) + (b * e - i) == 0) {
                                        prods << 1000 * f + 100 * g + 10 * h + i
                                        //println(prods)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
println(prods.sum())
