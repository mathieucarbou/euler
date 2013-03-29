Map() = [Set(),List()];

mapsearch(m,k) = setsearch(m[1],k);

mapput(m,k,v) =
{
    my(l, i=setsearch(m[1],k));
    if(i, m[2][i]=v, i=setsearch(m[1],k,1); m[1]=setunion(m[1],[k]); listinsert(m[2],v,i));
    return(m);
}

mapincr(m,k,v=1) =
{
    my(l, i=setsearch(m[1],k));
    if(i, m[2][i]=m[2][i]+v, i=setsearch(m[1],k,1); m[1]=setunion(m[1],[k]); listinsert(m[2],v,i));
    return(m);
}

mapget(m,k,d="") =
{
    my(i=setsearch(m[1],k));
    if(i, m[2][i], if(d!="", d, error("[mapget] key not found: " k)));
}
