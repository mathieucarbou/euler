/*
    If a prime has one of 0, 2, 4, 5, 6 or 8, it means that a rotation of the number will end up to be divisible by 2 or 5.
    So for a prime number to be circular, its digits can only be 1, 3, 7 or 9.
*/

{
    l=List();
    p=7;
    while(#l<11,
        p=nextprime(p+2);
        if(!isprime(p), next());
        qr=divrem(p,10);
        t=qr[2];
        b=1;
        while(t!=p && isprime(qr[1]) && isprime(t),
            qr=divrem(qr[1],10);
            b*=10;
            t+=qr[2]*b;
        );
        if(t!=p, next());
        listput(l,p);
    );
    print(sum(i=1,#l,l[i]));
}

\q
