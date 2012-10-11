/*
    http://www.9math.com/book/sum-squares-first-n-odd-natural-numbers

    x = length of the square: 1,3,5,...,1001

    4 equations to generate diagonal numbers:

        ne(x) = x^2
        nw(x) = x^2 - x + 1
        sw(x) = x^2 - 2*x + 2
        se(x) = x^2 - 3*x + 3

    S = sum for x odd from 3 to 1001.
    There are (1001-3)/2+1 = 500 odd numbers from 3 to 1001.
    1 must be only counted once.

        1 + S(ne(x) + nw(x) + sw(x) + se(x)) = 1 + S(4*x^2 - 6*x + 6)
                                             = 1 + 4*S(x^2) - 6*S(x) + 6*500

        S(x) = 500*(3+1001)/2
        S(x^2) = 501*(2*501-1)*(2*501+1)/3 - 1 (501 terms from 1..1001, then we substract 1)

*/

print(1 + 4*(501*(2*501-1)*(2*501+1)/3-1) - 6*500*(3+1001)/2 + 6*500)

\q
