Set<BigInteger> numbers = new TreeSet<BigInteger>();
for(def i in 2G..100G) {
    for(def j in 2..100) {
        numbers.add(i.pow(j))
    }
}
println numbers.size()
