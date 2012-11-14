/*
    http://en.wikipedia.org/wiki/Cyclic_number

    Cyclic numbers are related to the recurring digital representations of unit fractions. A cyclic number of length L is the digital representation of
    1/(L + 1)
    Conversely, if the digital period of 1 /p (where p is prime) is
    p - 1,
    then the digits represent a cyclic number

    For example:
    1/7 = 0.142857 142857…
*/

\\ print(142857)

\r euler.gp

{
    p=2;
    while(1,
        p++;
        while(!isprime(p), p++; p=nextprime(p));
        c=cycle(p);
        if(c[2]==p-1,
            s=vecsort(digits(c[1]));
            f=1;
            for(i=2, 6, if(s!=vecsort(digits(i*c[1])), f=0; break()));
            if(f, print(c[1]); break());
        );
    );
}

\q
