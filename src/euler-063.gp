/*
    10^n has n+1 digits. So we only need to test a^n with a<10 and n>=1

    limits of n for given a

        9^10=3486784401 (10 digits)
        9^20=12 157665 459056 928801 (20 digits)
        9^40=147 808829 414345 923316 083210 206383 297601 (39 digits)

        So we can find value n for each a so that a^n have less than n digits.

        Length of a number n: floor(log(n)/log(10))+1
        We want to find all a^n so that
            -1 < floor(log(a^n)/log(10))-n+1 < 1
            => floor(n*log(a)/log(10))-n+1 = 0
*/

c=0
for(a=1,9, n=1; t=0; until(t, c++; n++; t=floor(n*log(a)/log(10))-n+1))
print(c)

\q
