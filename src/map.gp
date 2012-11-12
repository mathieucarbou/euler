Map() = [Set(),List()];

mapsearch(m,k) = setsearch(m[1],k);

mapput(m,k,v) =
{
    my(l, i=setsearch(m[1],k));
    if(i, m[2][i]=v; return(m));
    i=setsearch(m[1],k,1);
    if(i>#m[2], listput(m[2],v), listinsert(m[2],v,i));
    [setunion(m[1],[k]), m[2]];
}

mapincr(m,k,v=1) =
{
    my(l, i=setsearch(m[1],k));
    if(i, m[2][i]=m[2][i]+v; return(m));
    i=setsearch(m[1],k,1);
    if(i>#m[2], listput(m[2],v), listinsert(m[2],v,i));
    [setunion(m[1],[k]), m[2]];
}

mapget(m,k,d="") =
{
    my(i=setsearch(m[1],k));
    if(i, m[2][i], if(d!="", d, error("[mapget] key not found: " k)));
}
