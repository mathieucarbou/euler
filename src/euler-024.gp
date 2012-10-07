/*
    http://en.wikipedia.org/wiki/Factorial_number_system
*/

base=vector(10,b,(10-b)!)
print("Base: " base)

n=1000000-1

factoradic=List()

for( i=1, 10, listput(factoradic, n\base[i]); n=n%base[i] )
print("Factoradic representation: " factoradic)

digits=List(vector(10,d,d-1))
print("Digits: " digits)

print1("1000000th permutation: ")
for( i=1, 10, print1(digits[factoradic[i]+1]); listpop(digits, factoradic[i]+1) )

\q
