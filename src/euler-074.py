from itertools import combinations_with_replacement,permutations

f = {0:1,1:1,2:2,3:6,4:24,5:120,6:720,7:5040,8:40320,9:362880}
def nextFact(n):
    t = 0
    while n:
        t+=f[n%10]
        n//=10
    return t
def numTup(a):
    s = []
    for i in a:
        s.append(str(i))
    return int("".join(s))

def factChain(n):
    n = nextFact(n)
    i = 0
    ff = []
    while n not in ff:
        ff.append(n)
        n = nextFact(n)
        i+=1
    return i
t = 0
# six letters, so...
numsToTry = combinations_with_replacement(range(0,10),6)
for i in numsToTry:
    n = numTup(i)
    l = factChain(n)
    if l==59:
        print i
