// Created 2019-06-30 by LimeThaw

/**
 *  A Breadth-First Search algorithm. Finds a shortest path in terms of edge count
 *  within a directed graph, if it exists.
 *  - param adjacency:  A quadratic matrix which carries information about edges in the
 *                      graph. For each directed edge between two nodes, there is a
 *                      value greater than zero in the matrix. Entries leq zero mean that
 *                      there is no edge between the corresponding nodes.
 *  - param source:     The index of the starting node
 *  - param sink:       The index of the goal node
 *  - returns:          A list containing the indices of the nodes along the path found,
 *                      or nil if no path is found.
 */
public func BFS<T: Numeric & Comparable>(adjacency matrix: Matrix<T>, source: Int, sink: Int) -> [Int]? {

    // Make sure our input is valid
    assert(matrix.size.0 == matrix.size.1)
    assert(source >= 0 && source < matrix.size.0)
    assert(sink >= 0 && sink < matrix.size.0)
    
    // Initialize intermediate and return variables
    let n = matrix.size.0
    var visited = Array(repeating: false, count: n)
    var parent = Array<Int>(repeating: -1, count: n)
    var q = Queue<Int>()
    
    // Initialize the problem
    q.enqueue(source)
    visited[source] = true
    
    // Check if we have another node to process
    while !q.isEmpty {
    
        let node = q.dequeue()!
        
        // Remember that we already visited this node, so we don't get stuck in loops
        visited[node] = true
        
        for i in 0..<n {
        
            // If the node has a neighbor we haven't processed...
            if matrix[node, i]! > 0 && !visited[i] {
            
                // Remember where we came from to be able to construct a path
                parent[i] = node
                
                // Check if we are already at our goal
                if i == sink {
                    // If we reached the sink, construct the path and return it
                    var ret = [i]
                    var k = i
                    while k != source {
                        k = parent[k]
                        assert(k != -1, "Parent not set during BFS")
                        ret.insert(k, at: 0)
                    }
                    return ret
                }
                
                // If it's not the sink, queue it up for instpection
                q.enqueue(i)
            }
        }
    
    }
    
    // Nothing to inspect, and didn't reach the goal :(
    return nil
    
}
