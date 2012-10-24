/*
    http://en.wikipedia.org/wiki/Pythagorean_triple

    a = d*(m^2 - n^2)
    b = d*2*m*n
    c = d*(m^2 + n^2)

    with m > n > 0, m and n being coprimes and exactly one of m and n even. d is the greatest common divisor of a, b and c.

    a + b + c = p
    2*d*m * (m + n) = p
        => p must be even (p%2=0)

    pp=p/2
    d*m*(m + n) = pp
        => pp%m=0

    if n=1, d=1, m^2 + m - pp = 0
        => 1 < m < floor(sqrt(0.25 + pp))-0.5)

    k=m+n
    d*m*k = pp
    k is odd
    gcd(m,k)=1
        => if dk is even, is means k%2=0 (we remove all powers of 2)
        => dk=pp/m and m < k < 2*m (since n < m)
*/


\r euler.gp

m=[0,[]]
forstep(x=2,1000,2,p=pythagoreans(x); if(#m[2]<#p, m=[x,p]))
print(m[1])

\q
