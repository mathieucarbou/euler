v=apply(x->sumdigits(truncate(sqrt(x)*10^99)), select(x->!issquare(x), vector(100,x,x)))
print(sum(i=1,#v,v[i]))

\q
