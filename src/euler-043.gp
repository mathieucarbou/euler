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

    find m=d3d4d5d6 then find n=d6d7d8d9d10

*/

{
    lm=List();
    b1=Set(vector(10,i,i-1));
    b2=Set([0,5]);
    forstep(m=021,987,3,
        d4=(m\10)%10;
        if(d4%2==0,
            d3=m\100;
            if(d3 != d4,
                d5=m%10;
                if(d3 != d5 && d4 != d5,
                    i=setintersect(Set([d3, d4, d5]), b2);
                    if(#i==0,
                        listput(lm, [d3, d4, d5, 0]);
                        listput(lm, [d3, d4, d5, 5]),
                        if(#i==1,
                            if(i[1]==0,
                                listput(lm, [d3, d4, d5, 5]),
                                listput(lm, [d3, d4, d5, 0]);
                            );
                        );
                    );
                );
            );
        );
    );
    print(lm);
}

\q
