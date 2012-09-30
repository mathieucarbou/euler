/*
    This is the same as finding the longest path in a graph. We can do this by using negative weight and the Bellman–Ford algorithm alorithm.

    => http://en.wikipedia.org/wiki/Bellman%E2%80%93Ford_algorithm
 */

import org.jgrapht.alg.BellmanFordShortestPath
import org.jgrapht.experimental.dag.DirectedAcyclicGraph
import org.jgrapht.graph.DefaultWeightedEdge

// just because the problem 67 is the same, so the code is re-used
def TRIANGLE = args.length ? args[0] : '../data/euler-018.txt'

def graph = new DirectedAcyclicGraph<String, DefaultWeightedEdge>(DefaultWeightedEdge)
graph.addVertex('root')

def lines = new File(TRIANGLE).readLines()

for (int row = lines.size() - 1; row >= 0; row--) {
    lines[row].split(' ').eachWithIndex {weight, col ->
        def vertex = "(${row},${col})" as String
        graph.addVertex(vertex)
        if (row == lines.size() - 1) {
            graph.setEdgeWeight(graph.addDagEdge('root' as String, vertex), -(weight as int))
        } else {
            graph.setEdgeWeight(graph.addDagEdge("(${row + 1},${col})" as String, vertex), -(weight as int))
            graph.setEdgeWeight(graph.addDagEdge("(${row + 1},${col + 1})" as String, vertex), -(weight as int))
        }
    }
}

def path = new BellmanFordShortestPath<String, DefaultWeightedEdge>(graph, 'root' as String)
println(-path.getCost('(0,0)' as String))
path.getPathEdgeList('(0,0)' as String).each {print it}
