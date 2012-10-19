/*
    If a prime has one of 0, 2, 4, 5, 6 or 8, it means that a rotation of the number will end up to be divisible by 2 or 5.
    So for a prime number to be circular, its digits can only be 1, 3, 7 or 9.
*/

{
    c=0;
    m=1000000;
    b=log(10);
    l=List(primes(primepi(m)));
    while(#l,
        if(l[1]<10, c++; listpop(l,1); next());
        p=10^(floor(log(l[1])/b));
        qr=[l[1],0];
        rp=1;
        while(1,
            qr=divrem(qr[1],p);
            if(qr[1]==5 || qr[1]%2==0, listpop(l,1); break());
            qr[1]=10*qr[2]+qr[1];
            if(l[1]==qr[1],
                c+=rp;
                listpop(l,1);
                break()
            );
            i=setsearch(l, qr[1]);
            if(i==0, listpop(l,1); break());
            rp++;
            listpop(l,i);
        );
    );
    print(c);
}

\q
