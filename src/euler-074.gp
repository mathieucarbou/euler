/*
    First try at the end is slow. 2nd with combinations is better, see just here.
*/

\r euler.gp

F=vector(10,x,(x-1)!)

\\ compute the chain length
chain(n) = {
    my(l=List(), s);
    while(setsearch(l, n)==0,
        listinsert(l, n, setsearch(l, n, 1));
        s=0;
        while(n, s+=F[(n%10)+1]; n=n\10);
        n=s;
    );
    l;
}

\\ combination with repetitions of 6 digits amongst 0-9
print1(select(n->#chain(n)==60, apply(x->subst(Pol(x),'x,10), ways(6, vector(10,x,x-1)))))

\\ compute possible permutations of found numbers (=> [1479, 223479])
\\ (1,4,7,9) => 4!
\\ (0,4,7,9) => 4! (because) 0! == 1!, but we must remove 3! because the arrangement 0(4,7,9) does not apply
\\ (2,2,3,4,7,9) => 6! / 2 because for each permutation, two same numbers are generated
print(" => " 6!/2+2*4!-3!)

/*
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
*/

\q
