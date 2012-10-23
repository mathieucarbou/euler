/*
    If p is the perimeter of a right angle triangle with integral length sides, {a,b,c},
    there are exactly three solutions for p = 120. {20,48,52}, {24,45,51}, {30,40,50}

    http://en.wikipedia.org/wiki/Pythagorean_triple

    a = k*(m^2 - n^2)
    b = k*2*m*n
    c = k*(m^2 + n^2)

    arbitrary pair of positive integers m and n with m > n and m > 1

    a + b + c = p
    a^2 + b^2 = c^2

    2*k*m^2 + 2*k*m*n = p
    2*k*m * (m + n) = p

        => p%2=0, p%k=0, p%m=0, p%(m+n)=0
        => 2*m*(m+1)=p =>2*m^2+2m-p=0

    if n=1, k=1: 2*m^2 + 2*m - p = 0

        => 1 < m < sqrt(1+2*p)/2

*/

\r euler.gp

forstep(x=2,1000,2,print("x: " pythagoreans(x)))

\q
