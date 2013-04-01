/*
    http://en.wikipedia.org/wiki/Pythagorean_triple
    http://en.wikipedia.org/wiki/Tree_of_primitive_Pythagorean_triples
    http://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples#Pythagorean_triples_by_use_of_matrices_and_linear_transformations
*/

N=1500000

A=[1,-2,2; 2,-1,2; 2,-2,3]
B=[1,2,2; 2,1,2; 2,2,3]
C=[-1,2,2; -2,1,2; -2,2,3]
M=[A, B, C]

C=0
\\ T=List()

S=[3;4;5]

berggrens(p, t) = {
    \\print(p " => " t);
    C++;
    \\ listput(T, Set(Vec(t)[1]));
    apply(m->berggrens(t, m), select(m->sum(i=1,3,m[i,1])<=N, apply(m->m*t, M)));
}

berggrens([], S)

print(C)
\\ print(T)
