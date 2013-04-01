/*
    Recomposition of n in base b by exponents. I.e. vectonum([1,2,3,4,5]) == 12345
*/
vectonum(v, b=10) = subst(Pol(v),'x,b);

/*
    Permutation number k (mod n!) of n letters (n C-integer).
*/
mynumtoperm(n, k) = Vec(Vecsmall(numtoperm(n,k))^(-1)*vectorsmall(n,i,n+1-i));

/*
    Number of digits of n in base b
*/
ndigits(n, b=10) =
{
    if(n==0, return(0));
    if(b==10, return(#Str(n)));
    1+floor(log(n)/log(b));
}

/*
    Representation of n in factoradic base b.
    The number n is taken modulo b!
*/
factoradic(n, b=10) =
{
    if(n==0, return(0));
    my(v=vector(b), qr=[0,n%(b!)]);
    for(i=1, b, qr=divrem(qr[2], (b-i)!); v[i]=qr[1]);
    vectonum(v, b);
}

/*
    Get the recurring cycle of the inverse of this number 1/n.
    The recurring cycle is the length of the period of the floating part of the decimal 1/n.
    We find the least number l that satisfy 10^l mod n = 1
    In example, 1/7 = 0.142857142857142857142... has a period of 142857, length 6.
    Returns a vector(2) containing the period at position 1 and its length at position 2
*/
cycle(n) =
{
    my(l=0,p=1,qr);
    while(l<n,
        l++;
        p*=10;
        qr=divrem(p,n);
        if(qr[2]==1, return([qr[1], l]));
    );
    [0, 0];
}

/*
    Compute the number of ways of making a number n with the sum of given values v
*/
ncombsum(n, v=vector(n-1,x,x)) =
{
    my(w);
    if(#v==0, return(1));
    w=vector(n+1);
    w[1]=1;
    for(i=1,#v, for(j=v[i],n, w[j+1]+=w[j-v[i]+1]));
    w[n+1];
}

/*
    Searches the specified list l for the specified value v using the
    binary search algorithm.  The array must be sorted. If it is not sorted,
    the results are undefined. If the array contains multiple elements with
    the specified value, there is no guarantee which one will be found.
    Returns the index of the search key, if it is contained in the array;
    otherwise, (-(insertion point) - 1).
*/
binarySearch(l, v) =
{
    my(low=1, high=#v, mid, mv);
    while(low <= high,
        mid = (low + high) >> 1;
        mv=l[mid];
        if(mv<v, low=mid+1, if (mv>key, high=mid-1, return (mid)));
    );
    -(low + 1);
}

/*
    Returns a list of Pythagorean triplets [a, b, c],
    for which a^2 + b^2 = c^2 and a + b + c = p
*/
pythagoreans(p) =
{
    my(l,m_max,dk,d,k_max,n);
    if(p%2!=0, return([]));
    p=p/2;
    l=List();
    m_max=floor(sqrt(0.25+p)-0.5);
    fordiv(p, m,
        if(m > m_max, break());
        dk=p/m;
        while(dk%2==0, dk=dk/2);
        k_max=2*m;
        fordiv(dk, k,
            if(k>=k_max, break());
            if(k>m && k%2==1 && gcd(m,k)==1,
                n=k-m;
                d=p/(k*m);
                listput(l, [d*(m^2-n^2), 2*d*m*n, d*(m^2+n^2)]);
            );
        );
    );
    Set(l);
}

/*
    Check if x = p(n) = n is pentagonal and returns n or 0 if not.
*/
ispentagonal(x) =
{
    my(qr=24*x+1);
    if(!issquare(qr), return(0));
    qr=truncate(sqrt(qr))+1;
    qr=divrem(qr,6);
    if(qr[2]==0, qr[1], 0);
}

/*
    Check if x = h(n) = n is hexagonal and returns n or 0 if not.
*/
ishexagonal(x) =
{
    my(qr=8*x+1);
    if(!issquare(qr), return(0));
    qr=truncate(sqrt(qr))+1;
    qr=divrem(qr,4);
    if(qr[2]==0, qr[1], 0);
}

/*
    Check if x = t(n) = n is triangular and returns n or 0 if not.
*/
istriangular(x) =
{
    my(qr=8*x+1);
    if(!issquare(qr), return(0));
    qr=truncate(sqrt(qr))-1;
    qr=divrem(qr,2);
    if(qr[2]==0, qr[1], 0);
}

triangle(n)   = n*(n+1)/2;
square(n)     = n^2;
pentagonal(n) = n*(3*n-1)/2;
hexagonal(n)  = n*(2*n-1);
heptagonal(n) = n*(5*n-3)/2;
octagonal(n)  = n*(3*n-2);

flatten(l) = {
    my(r, m=#l);
    if(m==0, return(l));
    r=List(l);
    while(m,
        s=List(r[1]);
        for(j=1, #s, listput(r, s[j]));
        listpop(r, 1);
        m--;
    );
    return(Vec(r));
}

/*
    Returns the continuous fraction representation period for an irrational number
*/
contfracroot(n, p=20) = {
    c=contfrac(sqrt(n),,p);
    if(#c==1, return(c));
    for(i=2, #c, if(c[i]==2*c[1], return(vecextract(c, Str(1 ".." i)))));
    error(Str("Cannot find period: increase realprecision (\\p)"));
}

/*
    Returns the fraction on the left of fraction f for Farey sequence n
*/
fareyleft(n, f) = {
    my(bestNum=0, bestDenom=1, currDenom=n, minDenom=1, a=numerator(f), b=denominator(f));
    while(currDenom>minDenom,
        currNum=(a*currDenom-1)\b;
        if(bestNum*currDenom<currNum*bestDenom,
            bestNum=currNum;
            bestDenom=currDenom;
            delta=a*currDenom-b*currNum;
            minDenom=currDenom\delta+1;
        );
        currDenom--;
    );
    return(bestNum/bestDenom);
}

\\ http://en.wikipedia.org/wiki/Tree_of_primitive_Pythagorean_triples
berggrens(f, p=[3;4;5]) = my(ABC=[[1,-2,2; 2,-1,2; 2,-2,3], [1,2,2; 2,1,2; 2,2,3], [-1,2,2; -2,1,2; -2,2,3]]); ( r(t) = if(f(t), apply(m->r(m*t),ABC)) ); r(p);

\\ http://rosettacode.org/wiki/Combinations_with_repetitions
ways(k,v,s=[])={
	if(k==0,return([]));
	if(k==1,return(vector(#v,i,concat(s,[v[i]]))));
	if(#v==1,return(ways(k-1,v,concat(s,v))));
	my(u=vecextract(v,2^#v-2));
	concat(ways(k-1,v,concat(s,[v[1]])),ways(k,u,s))
};

\\ http://rosettacode.org/wiki/Combinations_with_repetitions
nways(k,v)=binomial(#v+k-1,k);

\\ http://rosettacode.org/wiki/Pythagorean_triples
forprimpythagoreans(lim, f)={
    my(P);
    for(m=2, sqrtint(lim\2),
        forstep(n=1+m%2, min(sqrtint(lim-m^2),m-1), 2,
            P=2*m*(m+n);
            if(gcd(m,n)==1 && P<=lim, f(m, n, P))
        )
    );
};
