{
    p=List([2]);
    n=1;
    while(n+=2,
        if(isprime(n), listput(p, n),
            forstep(i=#p, 1, -1, qr=divrem(n-p[i],2); if(qr[2]==0 && issquare(qr[1]), next(2)));
            break();
        );
    );
    print(n);
}
\q
