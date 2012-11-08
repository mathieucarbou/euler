/*
    p: 2 3 5  7 11 ...
    c: 0 2 5 10 17 28 ...
*/

{
    c=List([0]);
    m=[2,1];
    forprime(p=2, 1000000,
        acc=p+c[#c];
        if(acc>1000000, break());
        for(j=1, #c-m[2],
            t=acc-c[j];
            if(t<1000000 && isprime(t),
                m=[t, #c+1-j];
            );
        );
        listput(c, acc);
    );
    print(m[1]);
}

\q
