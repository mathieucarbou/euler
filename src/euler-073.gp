c=0
for(d=5, 12000, for(n=floor(d/3+1), ceil(d/2-1), if(gcd(n,d)==1, c++)))
print(c)

\q
