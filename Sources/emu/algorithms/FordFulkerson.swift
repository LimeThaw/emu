// Created 2019-06-14 by LimeThaw

/**
 *  An implementation of the Ford-Fulkerson algorithm to determine the maximum flow
 *  between two nodes in a graph, whose edges are annotated with capacities.
 *  - parameter caps:   A matrix of edge capacities, one for each ordered pair of nodes
 *                      in the graph. If two nodes are not connected, the corresponding
 *                      capacities should be <= zero
 *  - parameter source: The index of the source node
 *  - parameter sink:   The index of the sink node
 *  - returns:          A tuple containing the maximum flow and a matrix of flow values
 *                      for each ordered pair of nodes. Currently, even unconnected
 *                      node pairs can have a flow value, due to the "back flow"
 *                      created during the algorithm.
 */
public func FordFulkerson<T: Numeric & Comparable>(caps mat: Matrix<T>, source: Int, sink: Int) -> (T, Matrix<T>) {

    // Make sure our data is in proper shape
    assert(mat.size.0 == mat.size.1)
    assert(source >= 0 && source < mat.size.0)
    assert(sink >= 0 && sink < mat.size.0)
    
    // Get the graph size and setup state and return variables
    let n = mat.size.0
    var flow = T(exactly: 0)!
    var flowmat = Matrix(h: n, w: n, value: T(exactly: 0)!)
    var caps = mat
    
    // Use BFS to look for an augmenting path in the graph
    while let path = BFS(adjacency: caps, source: source, sink: sink) {
    
        // Get all capacities along the path
        let pl = path.count
        var caplist = Array(repeating: T(exactly: 0)!, count: pl-1)
        for i in 0..<pl-1 {
            caplist[i] = caps[path[i], path[i+1]] ?? T(exactly: 0)!
        }
        
        // Determine the minimum capacity to augment the flow
        let aug = caplist.min()!
        
        // Make sure the path is actually useful
        if aug > 0 {
            // Increase overall flow
            flow += aug
            for i in 0..<pl-1 {
                // Adjust the capacities of the edges; Increase that of backwards edges
                // to allow "backflow"
                caps[path[i], path[i+1]]! -= aug
                caps[path[i+1], path[i]]! += aug
                flowmat[path[i], path[i+1]]! += aug
            }
        }
    
    }
    
    // Return our precious information
    return (flow, flowmat)
    
}

/**
 *  A bipartite version of the Ford-Fulkerson algorithm. It interfaces the general
 *  version with parameter transformations to make access easier.
 *  - parameter source: A list of capacities from the source to all nodes of category A
 *  - parameter mid:    A matrix of flow capacities from all nodes of category A to
 *                      all nodes of category B. If there is no edge, the capacity should
 *                      be zero.
 *  - parameter sink:   A list of capacities from all nodes of category B to the sink
 *  - returns:          A tuple containing the maximum flow and a matrix of flow values
 *                      for each pair of nodes from categories A and B respectively.
 */
public func FordFulkersonBipartite<T: Numeric & Comparable>(source: [T], mid: Matrix<T>, sink: [T]) -> (T, Matrix<T>) {
    
    // Get the dimensions of our graph
    let m = source.count
    let n = sink.count
    assert(mid.size == (m, n), "Illegal dimensions for adjacency matrix")
    
    // Packing the problem into a general FOrdFulkerson problem
    let k = m+n+2
    var adj = Matrix(h: k, w: k, value: T(exactly: 0)!)
    for i in 1...m {
        adj[0, i] = source[i-1]
    }
    for i in 1...n {
        adj[m+i, k-1] = sink[i-1]
    }
    for i in 0..<m {
        for j in 0..<n {
            adj[i+1, j+m+1] = mid[i, j]
        }
    }
    
    // Getting solution using the general version
    let (flow, flowmat) = FordFulkerson(caps: adj, source: 0, sink: k-1)
    
    var ret = Matrix(h: m, w: n, value: T(exactly: 0)!)
    
    // Reformulate into bipartite matrix
    for i in 0..<m {
        for j in 0..<n {
            ret[i, j] = flowmat[i+1, m+j+1]! - flowmat[m+j+1, i+1]!
        }
    }
    
    // Return the matrix of flow values
    return (flow, ret)
    
}
