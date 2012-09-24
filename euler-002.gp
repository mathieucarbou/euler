/*

=> http://en.wikipedia.org/wiki/Fibonacci_number

F0	F1	F2	F3	F4	F5	F6	F7	F8	F9	F10	F11	F12	F13	F14	F15	F16
0	1	1	2	3	5	8	13	21	34	55	89	144	233	377	610	987

Every 3rd number of the sequence is even and more generally, every kth number of the sequence is a multiple of Fk

Result = F3 + F6 + F9 + ... where Fx < 4000000

*/

s=i=f=0
while( f<4000000, s=s+f; i=i+3; f=fibonacci(i); )
print(s)

\q
