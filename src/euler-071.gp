/*
    * n/d is reduced if n and d are coprimes
    * given d>1, there is c=eulerphi(d) reduced fractions of the form n/d where n<d
    * we must find n/d so that 2/5 < n/d < 3/7
    * we reduce the bounds each time we find a newer one
*/

{
    l=2/5;
    u=3/7;
    forstep(d=1000000, 2, -1,
        n=truncate(d*3/7);
        m=truncate(numerator(l)*d/denominator(l));
        while(n>m, f=n/d; if(f>l && f<u, l=f); n--);
    );
    print(numerator(l));
}

\q
