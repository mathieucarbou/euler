/*
    Would be better using http://en.wikipedia.org/wiki/Farey_sequence
*/

c=0;
for(d=5, 12000, n=floor(d/3+1); c+=#select(x->gcd(x,d)==1, vector(ceil(d/2-1)-n+1, x, n+x-1)));
print(c);

\q
