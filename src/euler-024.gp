n=3
i=3
{
    for(x=0,i,
        p=numtoperm(n, x);
        print1(p " ");
        for(i=1,n,print1(n-p[i]));
        print("")
    )
}
\q

//2783915460
