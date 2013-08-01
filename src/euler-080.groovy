import org.jgrapht.alg.DijkstraShortestPath
import org.jgrapht.experimental.dag.DirectedAcyclicGraph
import org.jgrapht.graph.DefaultWeightedEdge

def matrix = new File('../data/euler-080.txt').readLines().collect { it.split(',').collect { it as double } }
def graph = new DirectedAcyclicGraph<String, DefaultWeightedEdge>(DefaultWeightedEdge)
def connect = { String from, String to, double weight ->
    graph.addVertex(from)
    graph.addVertex(to)
    graph.setEdgeWeight(graph.addDagEdge(from, to), weight)
}
connect 'start', '0,0', 0.0
connect '79,79', 'end', matrix[79][79]
(0..79).each { r ->
    (0..79).each { c ->
        if (r < 79) connect((r + ',' + c), ((r + 1) + ',' + c), matrix[r][c])
        if (c < 79) connect((r + ',' + c), (r + ',' + (c + 1)), matrix[r][c])
    }
}
println new DijkstraShortestPath<String, DefaultWeightedEdge>(graph, 'start', 'end').pathLength as int
