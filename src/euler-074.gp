\r map.gp

{
    NB=1000000;
    F=vector(10,x,(x-1)!);
    C=vector(NB);
    \\ setup loops
    C[169]=C[363601]=C[1454]=3;
    C[871]=C[45361]=2;
    C[872]=C[45362]=2;
    \\ main loop
    for(n=1, NB,
        if(n>10 && n%10==1, C[n]=C[n-1]; next());
        if(!C[n],
            l=List([n]);
            while(1,
                nn=l[1];
                s=0;
                while(nn, s+=F[(nn%10)+1]; nn=nn\10);
                if(s<=NB && C[s],
                    forstep(i=#l, 1, -1, if(l[i]<=NB, C[l[i]]=C[s]+i)); break()
                );
                if(setsearch(Set(l), s),
                    i=#l;
                    while(i,
                        if(l[i]<=NB, C[l[i]]=i);
                        if(l[i]==s, break(), i--)
                    );
                    for(j=1, i,
                        if(l[j]<=NB, C[l[j]]=i);
                    );
                    break()
                );
                listinsert(l, s, 1);
            )
        );
    );
    print(#select(x->x==60, C));
}

\q
