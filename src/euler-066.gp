/*
    http://en.wikipedia.org/wiki/Pell%27s_equation#Fundamental_solution_via_continued_fractions
    We reuse what's done in previous problem.
*/

l=List()
for(D=2, 1000, if(!issquare(D), listput(l, [select(s -> s[1]^2-D*s[2]^2==1, Vec(contfracpnqn(contfrac(sqrt(D)), 100)))[2][1], D])))
listsort(l)
print(l[#l][2])

\q
