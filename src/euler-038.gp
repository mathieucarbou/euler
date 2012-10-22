/*
    9 X (1,2,3,4,5) => 918273645

    M cannot end with 5, otherwise M*2 or M*4 will ends with 0

    918273645 is not the biggest, so the result will begin with 9 and M has at least 2 digits
        => M*a=9... > 918273645

    between 92 x (1,2) => 92|184 (too few digits)
    and     98 x (1,2) => 98|192 (too few digits)

    between 92 x (1,2,3) => 92|184|276 (too few digits)
    and     98 x (1,2,3) => 98|196|294 (too few digits)

            92 x (1,2,3,4) => (too many digits)

        => M has 3 digits ?

    between 921 x (1,2) => 921|1942 (too few digits)
    and     987 x (1,2) => 987|1974 (too few digits)

            921 x (1,2,3) => 921|1842|2763 (too many digits)

        => M has 4 digits ?

    between 9213 x (1,2) => 9213|18426 (9 digits !)
    and     9876 x (1,2) => 9876|19752 (9 digits !)

        => M = a*100000+b, with 9213 <= a <= 9876
*/

{
    p=Set(vector(9,i,i));
    n=9876;
    while(n>=9213,
        if(n%5!=0 && #setintersect(p,Set(digits(n*100000+n*2)))==9,
            print(n "" n*2);
            break();
        );
        n--;
    );
}

\q
