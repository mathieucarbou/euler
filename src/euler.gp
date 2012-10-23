/*
    Recomposition of n in base b by exponents. I.e. vectonum([1,2,3,4,5]) == 12345
*/
vectonum(v, b=10) = return(subst(Pol(v),'x,b));

/*
    Permutation number k (mod n!) of n letters (n C-integer).
*/
mynumtoperm(n, k) = return(Vec(Vecsmall(numtoperm(n,k))^(-1)*vectorsmall(n,i,n+1-i)));

/*
    Number of digits of n in base b
*/
ndigits(n, b=10) =
{
    if(n==0, return(0));
    if(b==10, return(#Str(n)));
    return(1+floor(log(n)/log(b)));
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
    return(vectonum(v, b));
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
    Compute the number of ways of making a number n with the sum of given values v
*/
ncombsum(n, v=[]) =
{
    my(w);
    if(#v==0, return(1));
    w=vector(n+1);
    w[1]=1;
    for(i=1,#v, for(j=v[i],n, w[j+1]+=w[j-v[i]+1]));
    return(w[n+1]);
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
    return -(low + 1);
}

/*
    Returns a list of Pythagorean triplets [a, b, c],
    for which a^2 + b^2 = c^2 and a + b + c = p
*/
pythagoreans(p) =
{
    my();
    for(m=2, ceil(sqrt(1+2*p)/2),

    );
}

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

List<IntTriplet> set = new ArrayList<IntTriplet>();
sum >>>= 1;
for (int m = 2, max = (int) (Math.sqrt(sum) + 1); m < max; m++) {
    if (sum % m == 0) {
        int sm = sum / m;
        while ((sm & 1) == 0) sm >>>= 1;
        for (int k = (m & 1) == 1 ? m + 2 : m + 1, m2 = m << 1; k < m2 && k <= sm; k += 2) {
            if (sm % k == 0 && Divisors.gcd(k, m) == 1) {
                int d = sum / (k * m);
                int n = k - m;
                set.add(IntTriplet.of(d * (m * m - n * n), (d * m * n) << 1, d * (m * m + n * n)));
            }
            k += 2;
        }
    }
}
return set;
*/
