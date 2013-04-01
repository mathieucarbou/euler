/*
    I used the Berggrens method to compute all primitive triples.
    Then for each triple i flagged all its declined triples beging multiplicators

    http://en.wikipedia.org/wiki/Tree_of_primitive_Pythagorean_triples
    http://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples#Pythagorean_triples_by_use_of_matrices_and_linear_transformations

    2nd method: http://rosettacode.org/wiki/Pythagorean_triples
*/

\r euler.gp

N=1500000
T=vector(N)

\\ berggrens(t->my(s=t[1,1]+t[2,1]+t[3,1]); if(s>N, 0, for(i=1, i=N\s, T[s*i]++); 1))
\\ print(#select(x->x==1,T))

forprimpythagoreans(1500000, (m,n,p)->for(i=1, i=N\p, T[p*i]++))
print(#select(x->x==1,T))

\q
