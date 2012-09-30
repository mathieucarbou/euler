print(factor(2520))

/*

2520 = 2^3 * 3^2 * 5 * 7

Between 11 and 20:
- 11, 13, 17, 19 are primes => add them to the least common multiple
- 12, 14, 15, 18, 20 aleady divides 2520
- 16 = 2*4 => add another 2 to the factors

*/

print(2^3 * 3^2 * 5 * 7 * 11 * 13 * 17 * 19 * 2)

\q
