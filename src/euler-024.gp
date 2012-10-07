/*
    http://en.wikipedia.org/wiki/Factorial_number_system
*/

n=1000000-1
factoradic=List()

for( i=1, 10, base=(10-i)!; listput(factoradic, n\base); n=n%base )
print("Factoradic representation: " factoradic)

digits=List(vector(10,d,d-1))
print("Digits: " digits)

print1("1000000th permutation: ")
for( i=1, 10, print1(digits[factoradic[i]+1]); listpop(digits, factoradic[i]+1) )

\q
