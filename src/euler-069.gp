/*
    Dump pari/gp way. There is a better solution (see doc).
*/
mn=mf=0
for(n=2,1000000, f=n/eulerphi(n); if(f>mf, mf=f; mn=n))
print(mn)
\q
