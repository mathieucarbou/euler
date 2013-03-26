/*
    lim eulerphi(n) -> n as n grows so to minimize n/eulerphi(n), we must find the biggest eulerphi(n) as possible

    So we must find the lower n and the higher eulerphi(n). eulerphi(n) counts numbers coprimes to n so if n is prime,
    the number of coprimes is high. So if n is prime it means eulerphi(n) = n-1.
    And n cannot be a permutation of n-1.

    So we guess the number will be a composite of two primes so that eulerphi(n)=(p1−1)(p2−1) is close to n.
    So both primes are close to sqrt(n). We can take as the upper bound 2*sqrt(n)
*/

\\ m=n=2
\\ forstep(i=10^7, 2, -1, t=eulerphi(i); if(i/t<m && vecsort(digits(i),,4)==vecsort(digits(t),,4), m=i/t; n=i))
\\ print(n)

{
    u=10^7;
    m=g=2;
    p=vecsort(primes(primepi(2*sqrt(u))),,4);
    for(i=1, #p,
        for(j=i, #p,
            n=p[i]*p[j];
            if(n<u,
                t=eulerphi(n);
                if(n/t<m && vecsort(digits(n),,4)==vecsort(digits(t),,4),
                    m=n/t;
                    g=n;
                )
            )
        )
    );
    print(g);
}

\q
