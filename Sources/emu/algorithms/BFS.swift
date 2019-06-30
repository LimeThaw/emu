// Created 2019-06-30 by LimeThaw

public func BFS(adjacency matrix: Matrix<Float>, source: Int, sink: Int) -> [Int]? {

    assert(matrix.size.0 == matrix.size.1)
    assert(source >= 0 && source < matrix.size.0)
    assert(sink >= 0 && sink < matrix.size.0)
    
    let n = matrix.size.0
    var visited = Array(repeating: false, count: n)
    var parent = Array<Int>(repeating: -1, count: n)
    var q = Queue<Int>()
    
    q.enqueue(source)
    visited[source] = true
    
    while !q.isEmpty {
    
        let node = q.dequeue()!
        visited[node] = true
        for i in 0..<n {
            if matrix[node, i]! > 0 && !visited[i] {
                parent[i] = node
                if i == sink {
                    var ret = [i]
                    var k = i
                    while k != source {
                        k = parent[k]
                        assert(k != -1, "Parent not set during BFS")
                        ret.insert(k, at: 0)
                    }
                    return ret
                }
                q.enqueue(i)
            }
        }
    
    }
    
    return nil
    
}
