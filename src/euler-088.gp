/*
    2 ≤ k ≤ 12000 and N > k
    k = number of factor + product of factors - sum of factors

    Finding maximum N:
    for k = 12000, I will find N with a maximum of two factors prime factors so that to complete with ones (1).
    109 * 113 = 12317 and 109 + 113 = 222. 2 + 12317 - 222 = 12097
    => We prepare all possible factors up to N=12097 and we do not consider primes
*/

{
    NK=vector(12000); \\ vector of N values for each k
    NK[2]=4;
    N=select(x->!isprime(x), vector(12097-5,x,x+5));
    print(N);
    for(n=1, #N,
        F=factor(N[n]);
        NF=0;
        V=apply(x -> NF=NF+x[2]; x[1]*x[2], Vec(F~));
        S=sum(i=1,#V,V[i]); \\ sum of these factors
        K=NF+N[n]-S;
        if(K>#NK, next());
        if(!NK[K] || NK[K] > N[n], NK[K]=N[n]; print("N=" N[n] ", k=" K));
    );
    print(NK);
}

\q

{
    N=6;
    while(1,
        F=factor(N);
        NF=0; \\ number of factors
        V=apply(x -> NF=NF+x[2]; x[1]*x[2], Vec(F~));
        S=sum(i=1,#V,V[i]); \\ sum of these factors
        K=NF+N-S;
        if(K > #NK, break());
        if(!NK[K], NK[K]=N; print("N=" N ", k=" K));
        N=N+1
    );
    print(NK);
    NK=Set(vecextract(NK, Str("2.." #NK)));
    print(NK);
    print(sum(i=1,#NK,NK[i]));
}

7587457
29512696