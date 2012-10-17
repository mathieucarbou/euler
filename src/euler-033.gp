/*
    (10*a + b) / (10*a + c) = b / c < 1
    10*a*c + b*c = 10*a*b + c*b
    c = b
    => impossible

    (10*b + a) / (10*c + a) = b / c < 1
    10*b*c + a*c = 10*c*b + a*b
    c = b
    => impossible

    (10*a + b) / (10*c + a) = b/c with b < c
    10*a*c + b*c = 10*c*b + a*b
    => possible

    (10*b + a) / (10*a + c) = b/c with b < c
    10*b*c + a*c = 10*a*b + c*b
    => possible
*/

{
    p=1;
    for(a=1,9,
        for(b=1,9,
            for(c=b+1,9,
                if((10*b + a) / (10*a + c) == b/c || (10*a + b) / (10*c + a) == b/c,
                    p*=b/c;
                    print(10*b + a "/" 10*a + c " = " b "/" c);
                )
            )
        )
    );
    print("=> " denominator(p));
}

\q
