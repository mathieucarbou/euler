/*
    I used the Berggrens method to compute all primitive triples.
    Then for each triple i flagged all its declined triples beging multiplicators

    http://en.wikipedia.org/wiki/Tree_of_primitive_Pythagorean_triples
    http://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples#Pythagorean_triples_by_use_of_matrices_and_linear_transformations
*/

N=1500000
T=vector(N)
ABC=[[1,-2,2; 2,-1,2; 2,-2,3], [1,2,2; 2,1,2; 2,2,3], [-1,2,2; -2,1,2; -2,2,3]]

berggrens(t) = {
    my(s=t[1,1]+t[2,1]+t[3,1]);
    for(i=1, i=N\s, T[s*i]++);
    apply(m->berggrens(m), select(m->sum(i=1,3,m[i,1])<=N, apply(m->m*t, ABC)));
}

berggrens([3;4;5])

print(#select(x->x==1,T))

\q
