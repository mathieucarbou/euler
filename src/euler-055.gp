{
    l=List();
    s=List();
    n=nr=[];
    for(i=196,9999,
        if(setsearch(l, i), next());
        listput(s, i);
        nr=Vecrev(digits(i));
        for(c=1,50,
            t=s[#s]+subst(Pol(nr),'x,10);
            if(t<10000 && setsearch(l, t), break());
            listput(s, t);
            n=Vec(digits(t));
            nr=Vecrev(n);
            if(n==nr, s=List(); break())
        );
        if(#s,
            apply(x->if(x<10000, listput(l, x)), s);
            listsort(l);
            s=List();
            \\ print(i " " #l " " l);
        );
    );
    print(#l);
}

\q
