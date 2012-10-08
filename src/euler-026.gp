/*
    http://en.wikipedia.org/wiki/Recurring_decimal#Fractions_with_prime_denominators
*/

\r euler.gp
{
    m=[142857, 6];
    forprime(p=2,1000,
        c=cycle(p);
        if(c[2] > m[2],
            m=c;
            print("1/" p " : " m);
        );
    )
}
\q
