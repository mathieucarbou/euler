import static java.lang.Math.sqrt

/*
    http://en.wikipedia.org/wiki/Triangular_number
        t(n) = n(n+1)/2
        n = (sqrt(8*t(n)+1)-1)/2 (an integer x is triangular if and only if 8*t(n)+1 is a square)
*/

def tn = [] as Set
def count = 0
new File('../data/euler-042.txt').text.replaceAll(' |"', '').split(',').each {word ->
    int sum = word.chars.inject(0, {s, c -> s + (c as int) - 64})
    if (sum in tn) count++
    else {
        int test = 8 * sum + 1
        int root = sqrt(test)
        if (root * root == test && root % 2 == 1) {
            tn << sum
            count++
        }
    }
}
println(count)
