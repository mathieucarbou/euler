/*
    A number of the form 10x + y is divisible by 7 if and only if x − 2y is divisible by 7
        i.e. 371 = 37*10+1 => 37-2*1=35

    4-digits numbers (1234)
        * must not end with 2 or 4
        * must be > 2143

    5-digits numbers (12345) => impossible since divisible by 3
    6-digits numbers (123456) => impossible since divisible by 3

    7-digits numbers (1234567)
        * must not end with 2,4,5,6

    8-digits numbers (12345678) => impossible since divisible by 3
    9-digits numbers (123456789) => impossible since divisible by 3
*/

{
    p=Set(vector(7,i,i));
    n=7654321;
    while(n>=1234567,
        if(n%5!=0 && Set(digits(n))==p && isprime(n),
            print(n);
            break();
        );
        n-=2;
    );
}

\q
