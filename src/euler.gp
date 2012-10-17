/*
    Digit decomposition of n in base b by ascending order of b exponents. I.e. digits(12345) == [1,2,3,4,5]
*/
vectonum(v, b=10) =
{
    my(n=0);
    for(i=1,#v, n+=v[i]*b^(#v-i));
    return(n);
}

/*
    Digit decomposition of n in base b by ascending order of b exponents. I.e. digits(12345) == [1,2,3,4,5]
*/
digits(n, b=10) =
{
    my(l=List(),qr=[n,0]);
    if(n==0, return([0]));
    while(qr[1], qr=divrem(qr[1],b); listput(l,qr[2]));
    return(Vecrev(l));
}

/*
    Number of digits of n in base b
*/
ndigits(n, b=10) =
{
    my(c=0);
    if(n==0, return(1));
    while(n, n=n\b; c++);
    return(c);
}

/*
    Sum of digits of n in base b
*/
sumdigits(n, b=10) =
{
    my(s=0,qr=[n, 0]);
    while(qr[1], qr=divrem(qr[1],b); s+=qr[2]);
    return(s);
}

/*
    Representation of n in factoradic base b.
    The number n is taken modulo b!
*/
factoradic(n, b=10) =
{
    my(v=vector(b), qr=[0,n%(b!)]);
    for(i=1, b, qr=divrem(qr[2], (b-i)!); v[i]=qr[1]);
    return(v);
}

/*
    Generates the n-th permutation (from 0 to base! - 1, as a row vector of length base)
    of the numbers 0 to base-1. The number n is taken modulo base!.
*/
numtoperm2(n, base=10) =
{
    my( v=vector(base), digits=List(vector(base,i,i-1)), f=factoradic(n, base) );
    for(i=1, base, v[i]=digits[f[i]+1]; listpop(digits, f[i]+1) );
    return (v);
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
    return([0, 0]);
}

/*
    Compute the number of ways of making a number n with the given values v
*/
nsumexp(n, v=[]) =
{
    my(w);
    if(#v==0, return(1));
    w=vector(n+1);
    w[1]=1;
    for(i=1,#v, for(j=v[i],n, w[j+1]+=w[j-v[i]+1]));
    return(w[n+1]);
}
