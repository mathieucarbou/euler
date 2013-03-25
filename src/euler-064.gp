/*
    For square roots: a continuous fraction ends its period when ai=2∗a0 example : sqrt(23) = [4;1,3,1,8] => 8=2∗4
    An estimate of the period length can be sqrt(n)*log(n)
*/

\p250

\\ Find the continued fraction and period given a precision
contfracroot(n, p=20) = {
    c=contfrac(sqrt(n),,p);
    if(#c==1, return(c));
    for(i=2, #c, if(c[i]==2*c[1], return(vecextract(c, Str(1 ".." i)))));
    error(Str("Cannot find period: increase realprecision (\\p)"));
}

f=0
for(n=1, 10000, c=contfracroot(n, truncate(sqrt(n)*log(n))); if((#c-1)%2==1, f++))
print(f)

\q
