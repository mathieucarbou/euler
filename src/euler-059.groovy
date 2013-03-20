/*
    http://en.wikipedia.org/wiki/Frequency_analysis
    http://en.wikipedia.org/wiki/Letter_frequencies
    * The space is the top used charater
    * The key is made up of 3 lower-case characters, repeated
    => we find for each key encryption the top tost used digit and xor it with 32
*/

def space = 32, keySize = 3, keyFreq = []
def msg = new File("../data/euler-059.txt").text.split(',').collect { it as Byte }
keySize.times { keyFreq << [:] }
msg.eachWithIndex { b, i -> keyFreq[i % keySize][b] = 1 + (keyFreq[i % keySize][b] ?: 0) }
def key = keyFreq.collect { it.max { it.value }.key }.collect { it ^ space }
for (int i = 0; i < msg.size(); i++) msg[i] = msg[i]^key[i % keySize]
println msg.sum()
