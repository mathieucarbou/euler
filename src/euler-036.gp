/*
    If a prime has one of 0, 2, 4, 5, 6 or 8, it means that a rotation of the number will end up to be divisible by 2 or 5.
    So for a prime number to be circular, its digits can only be 1, 3, 7 or 9.
*/

{
    s=0;
    for(i=1,1000000,
        a=Str(i);
        if(Vec(a)!=Vecrev(a), next());
        a=binary(i);
        if(a!=Vecrev(a), next());
        s+=i;
    );
    print(s);
}

\q
