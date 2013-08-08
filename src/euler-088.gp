/*

Here are all k and N: 2 <= k <= 12 is {4, 6, 8, 12, 15, 16}

k=2:    N=4 => 2^2 - 2*2 = 0*1
        2 * 2
        2 + 2

k=3:    N=6 => 2^1 * 3^1 - 1*2 - 1*3 = 1*1
        1 * 2 * 3
        1 + 2 + 3

k=4:    N=8 => 2^3 - 3*2 = 2*1
        1 * 1 * 2 * 4
        1 + 1 + 2 + 4

k=5:    N=8 => 2^3 - 3*2 = 2*1
        1 * 1 * 2 * 2 * 2
        1 + 1 + 2 + 2 + 2

k=6:    N=12 => 2^2 * 3^1 - 2*2 - 1*3 = 5*1 WARNING
        1 * 1 * 1 * 1 * 2 * 6
        1 + 1 + 1 + 1 + 2 + 6

k=7:    N=12 => 2^2 * 3^1 - 2*2 - 1*3 = 5*1
        1 * 1 * 1 * 1 * 1 * 3 * 4
        1 + 1 + 1 + 1 + 1 + 3 + 4

k=8:    N=12 => 2^2 * 3^1 - 2*2 - 1*3 = 5*1 WARNING
        1 * 1 * 1 * 1 * 1 * 3 * 2 * 2
        1 + 1 + 1 + 1 + 1 + 3 + 2 + 2

k=9:    N=15 => 3^1 * 5^1 - 1*3 - 1*5 = 7*1
        1 * 1 * 1 * 1 * 1 * 1 * 1 * 3 * 5
        1 + 1 + 1 + 1 + 1 + 1 + 1 + 3 + 5

k=10:   N=16 => 2^4 - 4*2 = 8*1
        1 * 1 * 1 * 1 * 1 * 1 * 1 * 1 * 4 * 4
        1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 4 + 4

k=11:   N=16 => 2^4 - 4*2 = 8*1
        1 * 1 * 1 * 1 * 1 * 1 * 1 * 1 * 2 * 2 * 4
        1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 * 2 + 4

k=12:   N=16 => 2^4 - 4*2 = 8*1
        1 * 1 * 1 * 1 * 1 * 1 * 1 * 1 * 2 * 2 * 2 * 2
        1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 2 + 2 + 2

NF = number of factors
S = sum of factors
Number of 1 = N - S
K = NF + N - S

This way we will find the maximum k. But for numbers like 8, 12, 16
which are multiples of 4, since 2*2 == 2+2, we must find the number
of reductions we can do, which is NR = e \ 2 where e is the number
of factor 2.

The same of multiple of 6 since 2*3 = 2+3 + 1

*/

{
    NK=vector(12000); \\ vector of N values for each k
    NK[2]=4;
    N=5;
    while(1,
        F=factor(N);
        NF=0; \\ number of factors
        V=apply(x -> NF=NF+x[2]; x[1]*x[2], Vec(F~));
        S=sum(i=1,#V,V[i]); \\ sum of these factors
        K=NF+N-S;
        if(K <= #NK && !NK[K], NK[K]=N; print("N=" N ", k=" K));

        \\ find reductions of K by using 2*2 == 4*4
        B=N;
        BK=K;
        while(B%4==0,
            B=B\4;
            BK=BK-1;
            if(BK <= #NK && !NK[BK], NK[BK]=N; print("N=" N ", k=" BK))
        );

        \\ find reductions of K by using 2*3 == 1 + 2+3
        B=N;
        BK=K;
        while(B%6==0,
            B=B\6;
            BK=BK-2;
            if(BK <= #NK && !NK[BK], NK[BK]=N; print("N=" N ", k=" BK))
        );

        if(K > #NK && F[1,1] != 2, break(), N=N+1);
    );
    print(NK);
    NK=Set(vecextract(NK, Str("2.." #NK)));
    print(NK);
    print(sum(i=1,#NK,NK[i]));
}

\q

7587457
29512696