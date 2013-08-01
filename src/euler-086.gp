/*
    If we put all the faces of the cube in 2 dimensions, the line between S to F is the
    larger side of a square triangle having one side 6 and one side 5+3.

    SF = sqrt(6^2+(5+3)^2) = 10

    Sides of the cube: A, B, C with all being <= M
        SF = A^2 + (B+C)^2 must be a perfect square

    For the maximum M: SF = M^2 + (2*M)^2 = 5*M^2

*/

{
    m=8;
    n=6;
    A=m^2-n^2;
    B=2*m*n;
    C=m^2+n^2;
    print(A " " B " " C);
    print("A + B + C = " A + B + C);
    print("A^2 + B^2 = C^2 : " A^2 " + " B^2 " = " C^2);
}

\q


A spider, S, sits in one corner of a cuboid room, measuring 6 by 5 by 3, and a fly, F, sits in the opposite corner.
By travelling on the surfaces of the room the shortest "straight line" distance from S to F is 10 and the path is shown on the diagram.

However, there are up to three "shortest" path candidates for any given cuboid and the shortest route doesn't always have integer length.

By considering all cuboid rooms with integer dimensions, up to a maximum size of M by M by M, there are exactly 2060 cuboids for which
the shortest route has integer length when M=100, and this is the least value of M for which the number of solutions first exceeds
two thousand; the number of solutions is 1975 when M=99.

Find the least value of M such that the number of solutions first exceeds one million.
