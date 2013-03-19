/*
    If a prime has one of 0, 2, 4, 5, 6 or 8, it means that a rotation of the number will end up to be divisible by 2 or 5.
    So for a prime number to be circular, its digits can only be 1, 3, 7 or 9.
*/

{
    b=Set([0,2,4,5,6,8]);
    c=13;
    p=List(select(x->x>100, primes(primepi(1000000))));
    while(#p,
        d=digits(p[1]);
        listpop(p, 1);
        if(#setintersect(Set(d), b)==0,
            d=List(d);
            for(i=2,#d,
                listput(d, d[1]);
                listpop(d,1);
                j=setsearch(p, subst(Pol(Vec(d)),'x,10));
                if(j,
                    listpop(p, j),
                    next(2)
                );
            );
            c+=#d;
        );
    );
    print(c);
}

\q
