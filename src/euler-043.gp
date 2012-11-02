/*
    http://en.wikipedia.org/wiki/Divisibility_rule

     1  4  0  6  3  5  7  2  8  9
    d1 d2 d3 d4 d5 d6 d7 d8 d9 d10

        1. d2d3d4 = 406 is divisible by 2
            => d4: 0,2,4,6,8

        2. d3d4d5 = 063 is divisible by 3
            => (d3 + d4 + d5) % 3 == 0

        3. d4d5d6 = 635 is divisible by 5
            => d6 == 0 || d6 == 5

        4. d5d6d7 = 357 is divisible by 7

        5. d6d7d8 = 572 is divisible by 11
            => (d6 - d7 + d8) % 11 == 0
            => 1 <= d8 <= 9

        6. d7d8d9 = 728 is divisible by 13
            => (d9 - 3*d8 - 4*d7) % 13 == 0

        7. d8d9d10 = 289 is divisible by 17

    1 <= d1 <= 9

*/

{
    s=0;
    for(k=0, 10!-1,
        d=numtoperm(10,k);
        if(d[1]!=1 && d[8]>1 && (d[6]==1 || d[6]==6) && d[4]%2 && (d[3]+d[4]+d[5])%3==0,
            d=apply(x->x-1, d);
            if((d[5]*100+d[6]*10+d[7])%7==0 && (d[6]-d[7]+d[8])%11==0 && (d[9]-3*d[8]-4*d[7])%13==0 && (d[8]*100+d[9]*10+d[10])%17==0,
                s+=subst(Pol(d),'x,10);
            );
        );
    );
    print(s);
}

\q
