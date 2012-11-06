/*
    http://en.wikipedia.org/wiki/Divisibility_rule

    1. d2d3d4 = 406 is divisible by 2
        => d4: 0,2,4,6,8

    2. d3d4d5 = 063 is divisible by 3
        => (d3 + d4 + d5) % 3 = 0

    3. d4d5d6 = 635 is divisible by 5
        => d6 = 0 || d6 = 5

    4. d5d6d7 = 357 is divisible by 7

    5. d6d7d8 = 572 is divisible by 11
        => (d6 - d7 + d8) % 11 = 0
        => 1 <= d8 <= 9

    6. d7d8d9 = 728 is divisible by 13
        => (d9 + 10*d8 + 9*d7) % 13 = 0

    7. d8d9d10 = 289 is divisible by 17
*/

{
    s=0;
    base=vector(10,i,i-1);
    forstep(d8d9d10=17, 999, 17,
        d8=d8d9d10\100;
        d9=(d8d9d10\10)%10;
        d10=d8d9d10%10;
        s_d8d9d10=Set([d8, d9, d10]);
        if(#s_d8d9d10==3,
            s_d7=select(x->(d9+10*d8+9*x)%13==0, setminus(base, s_d8d9d10));
            for(i_d7=1,#s_d7,
                d7=s_d7[i_d7];
                s_d6=select(x->(x-d7+d8)%11==0, setminus([0,5], setunion(s_d8d9d10, [d7])));
                for(i_d6=1,#s_d6,
                    d6=s_d6[i_d6];
                    s_d5=select(x->(100*x+10*d6+d7)%7==0, setminus(base, setunion(s_d8d9d10, Set([d6,d7]))));
                    for(i_d5=1,#s_d5,
                        d5=s_d5[i_d5];
                        s_d4=setminus([0,2,4,6,8], setunion(s_d8d9d10, Set([d5,d6,d7])));
                        for(i_d4=1,#s_d4,
                            d4=s_d4[i_d4];
                            s_d3=select(x->(x+d4+d5)%3==0, setminus(base, setunion(s_d8d9d10, Set([d4,d5,d6,d7]))));
                            for(i_d3=1,#s_d3,
                                d3=s_d3[i_d3];
                                s_d2=setminus(base, setunion(s_d8d9d10, Set([d3,d4,d5,d6,d7])));
                                for(i_d2=1,#s_d2,
                                    d2=s_d2[i_d2];
                                    s_d1=setminus(base, setunion(s_d8d9d10, Set([d2,d3,d4,d5,d6,d7])));
                                    for(i_d1=1,#s_d1,
                                        d1=s_d1[i_d1];
                                        s+=eval(Str(d1""d2""d3""d4""d5""d6""d7""d8d9d10));
                                    );
                                );
                            );
                        );
                    );
                );
            );
        );
    );
    print(s);
}

\q
