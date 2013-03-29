\r map.gp

f=vector(10,x,(x-1)!)

digitfactorialsum(n) = {
    my(d=digits(n), m=0);
    for(i=1, #d, m+=f[d[i]+1]);
    return(m);
}

{
    N=Set();
    C=List();
    for(n=1, 170,
        if(!setsearch(N, n),
            l=List([n]);
            while(1,
                s=digitfactorialsum(l[1]);
                c=-1; u=Set(l);
                if(setsearch(u, s), c=0, k=setsearch(N, s); if(k, c=N[k]));
                if(c>=0,
                    N=setunion(N, u);
                    forstep(i=#l, 1, -1, listinsert(C, c+i, setsearch(N, l[i])));
                    break();
                );
                listinsert(l, s, 1);
            )
        )
    )
}

\\ skip all %10 numbers
\\ cache lists

\q
