\r euler.gp

\\ we will compute sums and list combinations in a 10+9+8 = 27 length-array
S=vector(27,x,List())
apply(c->listput(S[sum(i=1,3,c[i])], c), comb(3, vector(10,x,x)))
S=select(l->#l>=5 && #Set(flatten(l))==10, S)

\\ shows that there are 8 sets (producing sums from 13 to 20) having 5 combinations (of 3 numbers) or more
\\ apply(l->print(sum(i=1,3,l[1][i]) " " Vec(l));, S)

\\ 5 lines with 3 slots each => 15 numbers
\\ 16-digit string => 10 is not repeated and stands at the head of a branch
\\ if 10 is outside, we guess small numbers are inside and big numbers outside, like the example
\\ so out number should begin with 6 (smaller outside digit) and we have 6,7,8,9,10 oustide if this is true
\\ we must find a number so that 10+a+b=6+c+d, a,b,c,d in 1,2,3,4,5
\\ and 1,2,3,4,5 repeats only 2 times and others 1 time

\\ => pencil and paper ! (sort of sudoku game)
\\ 653.1031.914.842.725

\\ by coding:
extract(c,d) = my(f=flatten(c)); Set(apply(k->#select(n->n==k, f), d));
for(i=1, #S, apply(x->print1(x), select(c->extract(c,[1,2,3,4,5])==[2] && extract(c,[6,7,8,9,10])==[1], comb(5, Vec(S[i])))))

print(" => " 6531031914842725)

\q
