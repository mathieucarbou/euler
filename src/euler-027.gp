
/*
    http://mathworld.wolfram.com/Prime-GeneratingPolynomial.html

    p(x) = x^2 + ax + b
        |a| < 1000
        |b| < 1000
        p is prime

    1. p(x) must generate prime numbers from x in [0,l[ where l is the limit
        p(0) = b
        => b must be prime

    2. p(b) = b^2 + ab + b which is not prime (divisible by b)
        => l <= b

    3. p(x) = x^2 + x + 41 is prime generating for x in [0,40[ => p(n-x) is also.
        p(n-x) = (n-x)^2 + (n-x) + 41
               = n^2 + x^2 -2nx +n -x +41
               = x^2 + x(-2n-1) + (n^2 + n + 41)
               = x^2 + Ax + B

    4. |A| < 1000 => |-2n-1| < 1000         => n in [-500,499]
       |B| < 1000 => |n^2 + n + 41| < 1000  => n^2 + n + 41 < 1000 and n^2 + n + 41 > -1000
                                            => roots: n = 30 or n = -31, which gives B = 971
       For n = 30 or n = -31, we have the biggest limit l = 971.

    5. if b = 30, a = -2*30-1 = -61...

*/

print(61*971)

\q
