/*
    If we put all the faces of the cube in 2 dimensions, the line between S to F is the
    larger side of a square triangle having one side 6 and one side 5+3.
        => SF = sqrt(6^2+(5+3)^2) = 10

    Sides of the cube: M, A, B with all being <= M
        => SF = M^2 + (A+B)^2 must be a square. A+B <= 2*M
*/

{
    M=0; C=0;
    while(C<1000000,
        M = M+1;
        for(AB=2, 2*M,
            if(issquare(M^2+AB^2),
                if(AB > M+1,
                    C = C + ((M+M+2-AB) \ 2),
                    C = C + (AB \ 2)
                )
            )
        )
    );
    print(M);
}

\q
