/*
    If p is the perimeter of a right angle triangle with integral length sides, {a,b,c},
    there are exactly three solutions for p = 120. {20,48,52}, {24,45,51}, {30,40,50}

    http://en.wikipedia.org/wiki/Pythagorean_triple

    a = k*(m^2 - n^2)
    b = k*2*m*n
    c = k*(m^2 + n^2)

    arbitrary pair of positive integers m and n with m > n and m > 1

    dividing a, b, and c by 2 will yield a primitive triple if m and n are coprime

    a + b + c = p

    2*k*m^2 + 2*k*m*n = p
    2*k*m * (m + n) = p

        => p%2=0, p%k=0, p%m=0, p%(m+n)=0
        => 2*m*(m+1)=p =>2*m^2+2m-p=0

    if n=1, k=1: 2*m^2 + 2*m - p = 0

        => 1 < m < sqrt(1+2*p)/2

*/

{

}

\q

/*
List<IntTriplet> set = new ArrayList<IntTriplet>();
sum >>>= 1;
for (int m = 2, max = (int) (Math.sqrt(sum) + 1); m < max; m++) {
    if (sum % m == 0) {
        int sm = sum / m;
        while ((sm & 1) == 0) sm >>>= 1;
        for (int k = (m & 1) == 1 ? m + 2 : m + 1, m2 = m << 1; k < m2 && k <= sm; k += 2) {
            if (sm % k == 0 && Divisors.gcd(k, m) == 1) {
                int d = sum / (k * m);
                int n = k - m;
                set.add(IntTriplet.of(d * (m * m - n * n), (d * m * n) << 1, d * (m * m + n * n)));
            }
            k += 2;
        }
    }
}
return set;
*/
