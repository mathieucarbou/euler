/*
    N is the smalest prime of the 8-prime family.
        => repeating digits of N: 0,1,2
        => we must find primes having repeating 0, 1 or 2 and test other combinations

    N prime
        => last digit: 1,3,7,9
        => last digit cannot be the one that is replaced

    By computing the sum of repeating digits S(d) mod 3, we find that the number will be divisible by 3
    at least for one repetition if N has 2 or 4 repeating digits

    i.e. for 2 repeating digits,
    mod 3 = 0 for 0+0, 3+3, 6+6, 9+9
    mod 3 = 1 for 2+2, 5+5, 8+8
    mod 3 = 2 for 1+1, 4+4, 7+7

    If N could have 3 repeating digits, S(d) will be divisible by 3 all the time so we must find 2 other
    digits so that it is not which gives a 5-digits number if we can find one, otherwise a 6-digits number.
*/

\r map.gp

primefamily(n,d) =
{
    my(c=1,s=d+1,p);
    while(s<=9,
        p=subst(Pol(apply(x->if(x==d, s, x), n)), 'x, 10);
        if(isprime(p),
            c++;
            \\ print(n " " s " " p);
        );
        s++;
    );
    \\ if(c>=8, print("==> "n));
    c>=8;
}

{
    forprime(p=10000, 999999,
        n=digits(p);
        m=Map();
        for(i=1,#n, m=mapincr(m,n[i]));
        for(i=0, 2,
            if(n[#n]!=i && mapget(m,i,0)==3 && primefamily(n,i),
                print(p);
                break(2);
            );
        );
    )
}

\q
