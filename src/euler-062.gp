/*
    We iterate over all numbers, for each cube we create the signature by ordering all digits in reverse order.
    We use a sort of map to stock all numbers having the same cube signature
    We stop when we found 5 numbers with same signature
    To improve search speed, we create a new map when the length of the cube number changes, because all cubes have the same length.
*/

{
    n=406; k=Set(); v=List(); l=0;
    while(1,
        ll=digits(n^3);
        if(l!=#ll, l=#ll; k=Set(); v=List());
        d=subst(Pol(vecsort(ll, cmp, 4)), 'x, 10);
        i=setsearch(k,d);
        if(i==0,
            i=setsearch(k,d,1);
            listinsert(v,List(),i);
            k=setunion(k,[d]);
        );
        listput(v[i], n);
        if(#v[i]==5, print(v[i][1]^3); break());
        n++;
    );
}

\q
