\r map.gp

f=vector(10,x,(x-1)!)

digitfactorialsum(n) = {
    my(d=digits(n), m=0);
    for(i=1, #d, m+=f[d[i]+1]);
    return(m);
}

m=Map()

{

    for(n=1, 170,
        l=List([n]);
        while(1,
            s=digitfactorialsum(l[#l]);
            c=mapget(m, s, 0);
            if(c,
                m=mapput(m, n, c+#l);
                print(n " " c+#l " " l " " s);
            break());
            if(setsearch(Set(l), s),
                print(n " " l);
                while(#l, i=listpop(l,1); m=mapput(m, i, #l+1));
                print(m);
                break();
            );
            listput(l, s);
        )
    )
}

\\ skip all %10 numbers
\\ cache lists

\q
