/*
    We need to compute all C(n,p) with 23 <= n <= 100 and 1 <= p =< n
    We know that C(n,1)=n and C(n,n)=1 So we can reduce to 1 < p < n.
    We can reduce the search knowing that C(n, p) = C(n, n-p). Thus: 1 < p <= n/2.
    If C(n,p) > 1000000, we double count for p and n-p, except if n=2p, where we count only one.
*/

c=0
for(n=23, 100, for(p=2, n\2, if(binomial(n,p) > 1000000, if(n==2*p, c++, c+=2))))
print(c)

\q
