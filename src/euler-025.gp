/*
    http://en.wikipedia.org/wiki/Fibonacci_number

    The number n is the first to have 1000 digits
    digits(n) = floor(log(n) / log(10)) + 1

    Fib(n) = round(Phi^n / sqrt(5))
        with Phi = (1 + sqrt(5)) / 2 (Gold number)

    Approximation:

    => log(Phi^n / sqrt(5)) / log(10) + 1 = 1000
    => log(Phi^n / sqrt(5)) = 999 * log(10)
    => n * log(Phi) - log(sqrt(5)) = 999 * log(10)
    => n = (999 * log(10) + log(sqrt(5))) / log((1 + sqrt(5)) / 2)


*/

print( round( (999 * log(10) + log(sqrt(5))) / log((1 + sqrt(5)) / 2) ) )

\q
