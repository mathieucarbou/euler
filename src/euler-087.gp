/*
    primes < sqrt(50000000)
    N = A + B + C where A, B and C are 2, 3 and 4 powers
*/

{
    M = 50000000;
    p2 = apply(x->x^2, primes(primepi(sqrtn(M, 2))));
    p3 = apply(x->x^3, primes(primepi(sqrtn(M, 3))));
    p4 = apply(x->x^4, primes(primepi(sqrtn(M, 4))));
    L = List();
    for(A = 1, #p2,
        for(B = 1, #p3,
            AB = p2[A] + p3[B];
            if(AB >= M, break());
            for(C = 1, #p4,
                N = AB + p4[C];
                if(N >= M, break());
                if(!setsearch(L,N), listinsert(L, N, setsearch(L,N,1)));
            )
        )
    );
    print(#L);
}

\q
