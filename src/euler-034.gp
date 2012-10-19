/*
    9*9! = 3265920 => maximum
*/

\r euler.gp

{
    v=vector(10,i,(i-1)!);
    c=0;
    for(n=3, 3265920,
        f=0;
        d=digits(n);
        for(i=1, #d, f+=v[d[i]+1]);
        if(n==f, c+=n);
    );
    print(c);
}

\q
