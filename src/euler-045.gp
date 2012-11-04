/*
    T(t) = t*(t+1)/2
    P(p) = p*(3*p-1)/2
    H(h) = h*(2*h-1)

    Every hexagonal number is a triangular number

    p*(3*p-1)/2 = H(h)
    3*p^2 - p - 2*H(h) = 0
    p = (srqt(1 + 24*H(h)) + 1) / 6

    => 1 + 24*H(h) must be a perfect square
    => srqt(1 + 24*H(h)) mod 6 = 5
*/

h=143; while(h++, s=48*h^2-24*h+1; if(issquare(s) && sqrt(s)%6 == 5, print(2*h^2-h); break()));

\q
