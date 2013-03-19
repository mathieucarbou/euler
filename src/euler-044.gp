\r euler.gp

{
    p=List();
    listput(p,1);
    k=2;
    while(k,
        listput(p, p[k-1] + 3*k - 2);
        forstep(j=k-1, 1, -1,
            d = p[k] - p[j];
            \\ print("k="k",j="j", d="d", p="p);
            if(setsearch(p, d),
                qr=24*(p[k]+p[j])+1;
                if((truncate(sqrt(qr))+1)%6==0 && issquare(qr),
                    print(d);
                    break(2);
                );
            );
        );
        k++;
    );
}

\q
