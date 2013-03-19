/*
    http://en.wikipedia.org/wiki/Square_root_of_2#Continued_fraction_representation

    We define the fraction p/q for each iteration.

    p(0)/q(0) => 1/1
    p(1)/q(1) => 3/2
    p(2)/q(2) => 7/5
    p(3)/q(3) => 17/12
    p(4)/q(4) => 41/29

    p(n)/q(n) => (p(n-1)+2*q(n-1))/(p(n-1)+q(n-1))
*/

p=q=t=1
c=0
for(i=1,1000, t=p; p+=2*q; q+=t; if(#Str(p) > #Str(q), c++))
print(c)

\q
