p=select(x->x>1000, primes(primepi(9999)))
for(i=1,#p, for(j=i+1,#p, n=p[j]+p[j]-p[i]; if(n<9999 && setsearch(p,n) && vecsort(digits(p[i]))==vecsort(digits(p[j])) && vecsort(digits(p[i]))==vecsort(digits(n)) && Str(p[i]""p[j]""n)!="148748178147", print(p[i]""p[j]""n))))
\q
