forprime(i=1000,9999, forprime(j=i+2, (9999+i)\2, n=2*j-i; if(isprime(n) && vecsort(digits(i))==vecsort(digits(j)) && vecsort(digits(i))==vecsort(digits(n)) && Str(i""j""n)!="148748178147", print(i""j""n))))
\q
