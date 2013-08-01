import org.jgrapht.alg.DijkstraShortestPath
import org.jgrapht.graph.DefaultDirectedWeightedGraph
import org.jgrapht.graph.DefaultWeightedEdge

def matrix = new File('../data/euler-083.txt').readLines().collect { it.split(',').collect { it as double } }
def graph = new DefaultDirectedWeightedGraph<String, DefaultWeightedEdge>(DefaultWeightedEdge)
def connect = { String from, String to, double weight ->
    graph.addVertex(from)
    graph.addVertex(to)
    graph.setEdgeWeight(graph.addEdge(from, to), weight)
}
connect 'start', '0,0', 0.0
connect '79,79', 'end', matrix[79][79]
(0..79).each { r ->
    (0..79).each { c ->
        String v = r + ',' + c
        if (c > 0) connect(v, r + ',' + (c - 1), matrix[r][c])
        if (c < 79) connect(v, r + ',' + (c + 1), matrix[r][c])
        if (r > 0) connect(v, (r - 1) + ',' + c, matrix[r][c])
        if (r < 79) connect(v, (r + 1) + ',' + c, matrix[r][c])
    }
}
println new DijkstraShortestPath<String, DefaultWeightedEdge>(graph, 'start', 'end').pathLength as int
