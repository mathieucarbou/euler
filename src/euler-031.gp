/*
    1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p)

    Now we must compute how many sums we have with combinations of 1p, 2p, 5p, 10p, 20p, 50p, 100p and 200p to make 200p
    We must find letters such that:

        200*a + 100*b + 50*c + 20*d + 10*e + 5*f + 2*g + 1*h = 200
*/

{
    s=0;
    for(a=0,1,
        for(b=0,2,
            if(200*a + 100*b > 200, break());
            for(c=0,40,
                if(200*a + 100*b + 5*c > 200, break());
                for(d=0,10,
                    if(200*a + 100*b + 50*c + 20*d > 200, break());
                    for(e=0,20,
                        if(200*a + 100*b + 50*c + 20*d + 10*e > 200, break());
                        for(f=0,40,
                            if(200*a + 100*b + 50*c + 20*d + 10*e + 5*f > 200, break());
                            for(g=0,100,
                                if(200*a + 100*b + 50*c + 20*d + 10*e + 5*f + 2*g > 200, break());
                                for(h=0,200,
                                    n = 200*a + 100*b + 50*c + 20*d + 10*e + 5*f + 2*g + h;
                                    if(n > 200, break());
                                    if(n == 200, s++)
                                )
                            )
                        )
                    )
                )
            )
        )
    );
    print(s);
}

\q
