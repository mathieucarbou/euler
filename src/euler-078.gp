/*
    http://en.wikipedia.org/wiki/Partition_(number_theory)
    http://en.wikipedia.org/wiki/Pentagonal_number_theorem

    p(n)=p(n-1)+p(n-2)-p(n-5)-p(n-7)+p(n-x)...
        x: numbers of the form m(3m−1)/2, where m is an integer. The signs in the summation alternate as (-1)^m
            m=1,−1,2,−2,3,...
        p(0) is taken to equal 1, and p(k) is taken to be zero for negative k.
*/

\r euler.gp

\\ generate some pentagonal numbers
penta=flatten(vector(300,i,[i*(3*i-1)/2,-i*(-3*i-1)/2]))

\\ init p(0)=1 and p(1)=1
p=List([1, 1])
{
    while(p[#p],
        s=0;
        k=1;
        while(penta[k]<=#p,
            if((k-1)%4<2, s=(s+p[#p-penta[k]+1])%1000000, s=(s-p[#p-penta[k]+1])%1000000);
            k++;
        );
        listput(p, s);
    )
}
print(#p-1)

\q
