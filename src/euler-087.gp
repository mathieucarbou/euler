/*
    primes < sqrt(50000000)
    N = A + B + C where A, B and C are 2, 3 and 4 powers
*/

\r euler.gp
p=apply(x -> [x, x^2, x^3, x^4], primes(primepi(sqrt(50000000))))
print(p)
N=List()
for(A=1, #p, for(B=1, #p, for(C=1, #p, listput(N, p[A][2] + p[B][3] + p[C][4]) )))
print(#Set(N))

\\print(comb(3, p))
\\ print(mynumtoperm(#p, 0))
\\ print(ways(3, p))
\\ print(vector(3!,k,numtoperm(4,k)))
\\ print(Set(apply(p -> p[1]^2 + p[2]^3 + p[3]^4, ways(3, p))))

\q
