/*
    http://mathworld.wolfram.com/AbundantNumber.html
    " 12 is the smallest abundant number"
    " the smallest number that can be written as the sum of two abundant numbers is 24"
    "Every proper multiple of a perfect number, and every multiple of an abundant number, is abundant"
    => "all integers greater than 20161 can be written as the sum of two abundant numbers"
    => Sum all numbers in [1..23] and we have to check numbers in [25..20161]
*/

abundants=List()
for(i=12, 20161, if(sigma(i) > 2*i, listput(abundants,i)))
s=sum(n=1,23,n)
{
    for(n=25, 20161,
        m=n\2; i=1; f=1;
        while(abundants[i]<=m, if(setsearch(abundants, n-abundants[i]), f=0; break(), i++));
        if(f, s+=n)
    )
}
print(s)
\q
