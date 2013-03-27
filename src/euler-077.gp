/*
    Same as problem 76...
*/

ncombsum(n, v=vector(n-1,x,x)) = {
    my(w);
    if(#v==0, return(1));
    w=vector(n+1);
    w[1]=1;
    for(i=1,#v, for(j=v[i],n, w[j+1]+=w[j-v[i]+1]));
    w[n+1];
}

n=10
c=0
until(c>=5000, n++; c=ncombsum(n, primes(primepi(n))))
print(n)

\q
