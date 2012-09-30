/*
    This is the same as finding the longest path in a graph. We can do this by using negative weight and the Bellman–Ford algorithm alorithm.

    => http://en.wikipedia.org/wiki/Bellman%E2%80%93Ford_algorithm
 */

import org.jgrapht.alg.BellmanFordShortestPath
import org.jgrapht.graph.DefaultDirectedWeightedGraph
import org.jgrapht.graph.DefaultWeightedEdge

def graph = new DefaultDirectedWeightedGraph(DefaultWeightedEdge)
graph.addVertex("START")

def lines = new File('../data/euler-018.txt').readLines()
for (int row = lines.size() - 1; row >= 0; row--) {
    lines[row].split(' ').eachWithIndex {weight, col ->
        def vertex = "(${row},${col})"
        graph.addVertex(vertex)
        if (row == lines.size() - 1) {
            graph.addEdge("START": "(${row + 1},${col})", vertex, -(weight as int))
        } else {
            graph.addEdge("(${row + 1},${col})", vertex, -(weight as int))
            graph.addEdge("(${row + 1},${col + 1})", vertex, -(weight as int))
        }
    }
}

def path = new BellmanFordShortestPath(graph, "START")
println(-path.getCost("(0,0)"))
path.getPathEdgeList("(0,0)").each {print it}