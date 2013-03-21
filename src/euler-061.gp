/*
    we must find 6 numbers having the pattern abcd with
    * a>0 and c>0 to be cyclic
    * 1000 > abcd < 9999

    For heach type, we prepare the numbers in the series which are >1000 and < 9999
    The octagonal serie is the shortest so we will iterate over this serie to find in the others numbers starting with the two last digit of current octogonal number
*/

\\ our list of formula to generate polygons
formula = [n->n*(n+1)/2, n->n^2, n->n*(3*n-1)/2, n->n*(2*n-1), n->n*(5*n-3)/2, n->n*(3*n-2)]

\\ the polygons generated for each formnula
polygons = vector(#formula,x,List())

\\ flatten lists of lists into a flat list
flatten(l) = {
    my(r, m=#l);
    if(m==0, return(l));
    r=List(l);
    while(m,
        s=List(r[1]);
        for(j=1, #s, listput(r, s[j]));
        listpop(r, 1);
        m--;
    );
    return(Vec(r));
}

\\ find cycles by beginning by an octogonal number
cycles(o, idx) = {
    if(#idx==0, return([[o]]));
    my(n, p=List(), ab=(o-(o%100))/100, s=vector(#idx,x,select(p->p%100==ab, polygons[idx[x]])));
    for(i=1, #s,
        for(j=1, #s[i],
            n=cycles(s[i][j], setminus(idx, [idx[i]]));
            for(k=1, #n, listput(p, concat(n[k], [o])));
        );
    );
    return(Set(p));
}

{
    for(p=1, #formula,
        for(n=round(solve(n=0,9999,formula[p](n)-1000)), round(solve(n=0,9999,formula[p](n)-9999)),
            k=formula[p](n);
            if(k>1000 && k<9999 && k%100>9, listput(polygons[p], k))
        );
        polygons[p] = Set(polygons[p]);
        \\ printf("%-16s %s\n", formula[p], polygons[p]);
    );
    c=flatten(select(x->x[#formula]%100 == (x[1]-(x[1]%100))/100, flatten(apply(x->cycles(x, vector(#formula-1,i,i)), polygons[#formula]))));
    \\ print(c);
    print(sum(x=1,#c, c[x]));
}

\q
