/*
    Dump pari/gp way. There is a better solution (see doc).
*/
\\ mn=mf=0
\\ for(n=2,1000000, f=n/eulerphi(n); if(f>mf, mf=f; mn=n))
\\ print(mn)

{
    n=2;
    p=2;
    while(1,
        until(isprime(p), p=nextprime(p+1));
        np=p*n;
        if(np<=1000000, n=np, print(n); break());
    )
}

\q
