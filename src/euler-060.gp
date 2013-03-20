/*
    Brute-force by iterating over all primes. This is faster than finding all subsets of pairs and doing intersection to find compatible sets.
    The trick to use brute-force is to determine how much primes to use and where to stop.
    Since we iterate over all primes with 5 loops, there is more chances that the lower sum (with lower primes) is found first, but this is not guaranted.

    I first tried with 1000 (wich ends fast and gives no response)
    Then I tried 10000 which gives a first response quite fast, and the sum gives the expected anwser.
*/

istuple(p1, p2) = {
    my(d1=digits(p1), d2=digits(p2));
    return(isprime(subst(Pol(concat(d1, d2)),'x,10)) && isprime(subst(Pol(concat(d2, d1)),'x,10)));
}

{
    p=primes(primepi(10000));
    for(p1=1, #p-4,
        for(p2=p1+1, #p-3,
            if(istuple(p[p1], p[p2]),
                for(p3=p2+1, #p-2,
                    if(istuple(p[p1], p[p3]) && istuple(p[p2], p[p3]),
                        for(p4=p3+1, #p-1,
                            if(istuple(p[p1], p[p4]) && istuple(p[p2], p[p4]) && istuple(p[p3], p[p4]),
                                for(p5=p4+1, #p,
                                    if(istuple(p[p1], p[p5]) && istuple(p[p2], p[p5]) && istuple(p[p3], p[p5]) && istuple(p[p4], p[p5]),
                                        print(p[p1] + p[p2] + p[p3] + p[p4] + p[p5]);
                                        break(5);
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
}

\q
