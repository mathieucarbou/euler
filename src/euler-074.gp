\r map.gp

f=vector(10,x,(x-1)!)

digitfactorialsum(n) = {
    my(d=digits(n), m=0);
    for(i=1, #d, m+=f[d[i]+1]);
    return(m);
}

{
    n=Set();
    c=List();
    for(i=1, 170,
        if(!setsearch(n, i),
            l=List([i]);
            while(1,
                s=digitfactorialsum(l[1]);
                j=setsearch(n, s);
                if(j,
                    k=setsearch(n, i, 1);


                    m=mapput(mc, n, c+#l);
                    print("F " n " " l " " s " " #l);
                    print(mc);
                    break();
                );
                if(setsearch(Set(l), s),
                    print("N " n " " l " " s " " #l);
                    forstep(i=#l, 1, -1, mc=mapput(mc, l[i], i));
                    print(mc);
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
