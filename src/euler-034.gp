/*
    145 = 0*0! + 1*1! + 0*2! + 0*3! + 1*4! + 1*5! (factoradic base)
    145 = 1*10^2 + 4*10 + 5                       (base 10)
*/

\r euler.gp

v=vector(10,i,(i-1)!)
print(v)
print(sum(i=1,#v,v[i]))

\q
