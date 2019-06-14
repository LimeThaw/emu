// Created 2019-06-14 by LimeThaw

func FordFulkerson<T: Numeric & Comparable>(source: [T], mid: Matrix<T>, sink: [T]) -> Matrix<T> {
    
    // Get the dimensions of our graph
    let m = source.count
    let n = sink.count
    assert(mid.size == (m, n), "Illegal dimensions for adjacency matrix")
    
    // Copy the inputs to get mutable capacities
    var scaps = source
    var acaps = mid
    var tcaps = sink
    
    // The variables that store the current flow
    var sf = Array(repeating: T(exactly: 0)!, count: m)
    var tf = Array(repeating: T(exactly: 0)!, count: n)
    var af = Matrix<T>(h: m, w: n, value: T(exactly: 0)!)
    
    // Cycle through all posible pairings
    for i in 0..<m {
        for j in 0..<n {
            
            // Get the capacity along the path
            let c = min(scaps[i]-sf[i], acaps[i, j]!-af[i, j]!, tcaps[j]-tf[j])
            if c>0 {
                // If path is augmenting update capacity and flow values
                scaps[i] -= c
                sf[i] += c
                acaps[i, j]! -= c
                af[i, j]! += c
                tcaps[i] -= c
                tf[i] += c
            }
        
        }
    }
    
    //let maxf = af.sum
    // Return the matrix of flow values
    return af
    
}
