/*
    Same as problem 76...
*/

\r euler.gp
n=10
c=0
until(c>=5000, n++; c=ncombsum(n, primes(primepi(n))))
print(n)

\q
