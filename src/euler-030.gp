/*
    http://mathworld.wolfram.com/NarcissisticNumber.html
        => 54748 + 92727 + 93084 = 240559

    Numbers can be composed of the sum of:
        0^5 = 0
        1^5 = 1
        2^5 = 32
        3^5 = 243
        4^5 = 1024
        5^5 = 3125
        6^5 = 7776
        7^5 = 16807
        8^5 = 32768
        9^5 = 59049

    We must find all remaining numbers in less than 5 digits plus those with more than 5 digits.

    For those < 5-digits, numbers can only be composed of 0,1,2,3,4,5,6 (=> 7! = 5040 combinations)
    For those with 6-digits: maximum is 6*9^5 = 354294
    For those with 7-digits: maximum is 7*9^5 = 413343 (oups! 6 digits also!)
        => so there cannot be numbers with 7-digits
        => we check numbers of 6-digits <= 354294
*/

\r euler.gp

base=vector(10,i,(i-1)^5)

sumdigpow(n) =
{
    my(d=digits(n),ss=0);
    for(i=1,#d,ss+=base[d[i]+1]);
    return(ss);
}

s=54748+92727+93084
for(n=100000,354294, if(n==sumdigpow(n), s+=n))
for(d1=0,6, for(d2=0,6, for(d3=0,6, for(d4=0,6, n=d1*1000+d2*100+d3*10+d4; if(n>1 && n==sumdigpow(n), s+=n)))));

print(s)

\q
