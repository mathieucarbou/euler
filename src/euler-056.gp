/*
    99^99 is 198-digits long and the sum is 936
    90^90 is 176-digits long and the sum is only 360
    Multiplying by 10 leads to more 0 digits, thus a lower sum
    So we take a guess and we will only try numbers in [91, 99]
*/

ms=0
forstep(a=99, 91, -1, forstep(b=99, 91, -1, s=sumdigits(a^b); if(ms<s, ms=s)))
print(ms)

\q
