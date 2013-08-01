/*
    primes < sqrt(50000000)
    N = A + B + C where A, B and C are 2, 3 and 4 powers
*/

{
    M = 50000000;
    p = apply(p->apply(x->x^p, primes(primepi(sqrtn(M, p)))), [2,3,4]) ;
    L = List();
    for(A = 1, #p[1],
        for(B = 1, #p[2],
            AB = p[1][A] + p[2][B];
            if(AB >= M, break());
            for(C = 1, #p[3],
                N = AB + p[3][C];
                if(N >= M, break());
                listput(L, N);
            )
        )
    );
    print(#Set(L));
}

\q
