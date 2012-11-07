Map() = [Set(),List()];

mapsearch(m,k) = setsearch(m[1],k);

mapput(m,k,v) =
{
    local(l, i=setsearch(m[1],k));
    if(i, m[2][i]=v; return(m));
    i=setsearch(m[1],k,1);
    if(i>#m[2], listput(m[2],v), listinsert(m[2],v,i));
    return([setunion(m[1],[k]), m[2]]);
}

mapget(m,k) =
{
    local(i=setsearch(m[1],k));
    if(i, return(m[2][i]));
    error("e_MAPGET");
}
