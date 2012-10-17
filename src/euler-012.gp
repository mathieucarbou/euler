i=t=1
n=numdiv(t)
while( n <= 500, i++; t+=i; n=numdiv(t) )
print(t)
\q
