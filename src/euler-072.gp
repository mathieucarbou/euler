/*
    * n/d is reduced if n and d are coprimes
    * given d>1, there is c=eulerphi(d) reduced fractions of the form n/d where n<d
*/

print(sum(d=2, 1000000, eulerphi(d)))

\q
