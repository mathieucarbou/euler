/*
    we must find 6 numbers having the pattern abcd with
    * a>0 and c>0 to be cyclic
    * 1000 > abcd < 9999

    For heach type, we prepare the numbers in the series which are >1000 and < 9999
    The octagonal serie is the shortest so we will iterate over this serie to find in the others numbers starting with the two last digit of current octogonal number
*/

\r euler.gp

accept(n) = n>1000 && n<9999 && n%100>9
formula = [triangle, square, pentagonal, hexagonal, heptagonal, octagonal]
m=#formula
polygons = vector(m,x,List())

previous(o, idx) = {
    if(#idx==0, return([o]));
    my(n, ab=(o-(o%100))/100, s=vector(#idx,x,select(p->p%100==ab, polygons[idx[x]])));
    for(i=1,#s,
        for(j=1, #s[i],
            n=previous(s[i][j], setminus(idx, [idx[i]]));
            if(#n, return(concat(n, [o])));
        );
    );
    return([]);
}

{
    for(p=1, m,
        for(n=round(solve(n=0,9999,formula[p](n)-1000)), round(solve(n=0,9999,formula[p](n)-9999)),
            k=formula[p](n);
            if(accept(k), listput(polygons[p], k))
        );
        polygons[p] = Set(polygons[p]);
        printf("%-16s %s\n", formula[p], polygons[p]);
    );

    for(p=1, #polygons[m],
        c=previous(polygons[m][p], vector(m-1,x,x));
        if(#c && polygons[m][p]%100 == (c[1]-(c[1]%100))/100, print(c), break());
    );
}

\q
