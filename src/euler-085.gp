/*
    http://www.gottfriedville.net/mathprob/comb-subrect.html
    => Find m and n such that m*(m+1)*n*(n+1)/4 = 2000000

    http://www.wolframalpha.com/input/?i=m*%28m%2B1%29*n*%28n%2B1%29%2F4+%3D+2000000
    By typing in Wolfram Alpha the equation, we see that
    m between 2 and 100 and m between 2 and 500 is sufficient for a search
*/

{
    p=q=r=0;
    for(m=2,100,
        n=truncate(solve(n=2,2000,m*(m+1)*n*(n+1)/4-2000000));
        o=m*(m+1)*n*(n+1)/4;
        if(o>r, r=o; p=m; q=n);
    );
    print(p*q);
}

\q
