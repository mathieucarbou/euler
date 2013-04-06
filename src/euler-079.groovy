import org.jgrapht.experimental.dag.DirectedAcyclicGraph
import org.jgrapht.graph.DefaultEdge
import org.jgrapht.traverse.TopologicalOrderIterator

/*
    First I read the file, removed duplicates and sorted numbers.
        => only 33 entries remain

    129, 160, 162, 168, 180
    289, 290
    316, 318, 319, 362, 368, 380, 389
    620, 629, 680, 689, 690
    710, 716, 718, 719, 720, 728, 729, 731, 736, 760, 762, 769, 790
    890

    By using an editor which highlight our search term, we search for digits 0-9.
        * There is no 4, no 5
        * 7 is always the 1st digit so it may be the first digit of the number
        * 0 is always the 3rd digit so it may be the last digit of the number

    We are using Topological Sorting to find all solutions.
    See http://en.wikipedia.org/wiki/Topological_sorting

*/

def attempts = new File('../data/keylog.txt').readLines().unique().sort()
//attempts.collect { it as int }.groupBy { (int) it / 100 }.each { println it.value.join(', ') }
def graph = new DirectedAcyclicGraph<String, DefaultEdge>(DefaultEdge)
attempts.each {String attempt->
    attempt.each {graph.addVertex(it)}
    graph.addDagEdge(attempt[0], attempt[1])
    graph.addDagEdge(attempt[0], attempt[2])
    graph.addDagEdge(attempt[1], attempt[2])
}
println((new TopologicalOrderIterator(graph) as List).join(''))
