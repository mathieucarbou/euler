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
