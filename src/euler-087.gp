/*
    primes < sqrtn(50000000,4)
    Greatest prime is 83 and 83^4+83^3+83^2 < 50000000.
*/

\r euler.gp
n=primepi(sqrtn(50000000,4))
print(n " " n^3)
p=primes(n)
print(p)

print(mynumtoperm(#p, 0))
print(ways(3, p))
print(comb(3, p))
print(vector(3!,k,numtoperm(4,k)))
print(Set(apply(p -> p[1]^2 + p[2]^3 + p[3]^4, ways(3, p))))

\q
