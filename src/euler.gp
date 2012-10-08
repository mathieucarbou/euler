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
    my(s=0);
    while(n, s+=n%b; n=n\b);
    return(s);
}

/*
    Representation of n in factoradic base b.
    The number n is taken modulo b!
*/
factoradic(b, n) =
{
    my(v=vector(b));
    n=n%(b!);
    for(i=1, b, base=(b-i)!; v[i]=n\base; n=n%base);
    return(v);
}

/*
    Generates the n-th permutation (from 0 to base! - 1, as a row vector of length base)
    of the numbers 0 to base-1. The number n is taken modulo base!.
*/
numtoperm2(base, n) =
{
    my( v=vector(base), digits=List(vector(base,i,i-1)), f=factoradic(base, n) );
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
    my(l=0,p=1);
    while(l<n,
        l++;
        p*=10;
        if(p%n==1, return([p\n, l]));
    );
    return([0, 0]);
}
