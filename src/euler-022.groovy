def sum = 0L
new File('../data/euler-022.txt').readLines().sort().eachWithIndex {name, pos ->
    sum += (pos + 1) * name.chars.inject(0, {s, c -> s + c - 64})
}
println sum
