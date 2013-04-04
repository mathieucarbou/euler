/*
    http://en.wikipedia.org/wiki/Partition_(number_theory)
    http://en.wikipedia.org/wiki/Pentagonal_number_theorem

    p(n)=p(n-1)+p(n-2)-p(n-5)-p(n-7)+p(n-x)...
        x: numbers of the form m(3m−1)/2, where m is an integer. The signs in the summation alternate as (-1)^m
            m=1,−1,2,−2,3,...
        p(0) is taken to equal 1, and p(k) is taken to be zero for negative k.
*/

// generate some pentagonal numbers
// init p(0)=1 and p(1)=1
def penta = (1..300).collect { [it * (3 * it - 1) / 2, -it * (-3 * it - 1) / 2] }.flatten().collect { it as int }
def p = [1, 1]
while (p[p.size() - 1]) {
    int s = 0;
    for (int k = 0; penta[k] <= p.size(); k++)
        if (k % 4 < 2)
            s = (s + p[p.size() - penta[k]]) % 1000000
        else
            s = (s - p[p.size() - penta[k]]) % 1000000
    p << s
}
println(p.size() - 1)
