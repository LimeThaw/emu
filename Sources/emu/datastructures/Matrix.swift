import Rainbow

/**
 A simple container for a 2 dimensional matrix of constant size with numeric values.
 All matrices are row-major, so the first coordinate indexes the row, and the second
 indexes the column.
 */
public struct Matrix<T: Numeric & Equatable> : Equatable {

    /// The size of the matrix
    public let size: (Int, Int)
    /// The values in the matrix
    private var data: [[T]]
    
    /// Default initializer, creating a matrix where every entry is a given default value
    public init(h: Int, w: Int, value: T) {
        size = (h, w)
        data = Array(repeating: Array(repeating: value, count: w), count: h)
    }
    
    /**
     Initializer creating a diagoal matrix where the values on the diagonal are
     given as a vector and the rest of the entries are a given default value
     */
    public init(diag vec: [T], def val: T) {
        let n = vec.count
        self.init(h: n, w: n, value: val)
        for i in 0..<n {
            data[i][i] = vec[i]
        }
    }
    
    /**
     Subscript operator for getting and setting values in the matrix.
     If the indexes are out of range, the operator will return nil or ignore the
     assignment and print a warning.
     */
    public subscript(_ x: Int, _ y: Int) -> T? {
        get {
            if 0<=x && x<size.0 && 0<=y && y<size.1 {
                return data[x][y]
            } else {
                return nil
            }
        }
        set {
            if 0<=x && x<size.0 && 0<=y && y<size.1 {
                data[x][y] = newValue!
            } else {
                print("Matrix index out of range: [\(x), \(y)]".yellow.bold)
                //Thread.callStackSymbols.forEach{print($0)}
            }
        }
    }
    
    /// Returns the sum of all elements in the matrix
    public func sum() -> T {
        let arr = data.reduce([], +)
        return Array(arr[1...]).reduce(arr[0], +)
    }
    
    /**
     Equal operator making matrices equatable. Two matrices are equal iff they have
     the same dimensions and all entries match.
     */
    public static func == (lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
    
        // Equal matrices must have the same size
        if lhs.size != rhs.size {
            return false
        }
        
        // Compare all values entry-wise
        for i in 0..<lhs.size.0 {
            for j in 0..<lhs.size.1 {
                if lhs[i, j]! != rhs[i, j]! {
                    // If any of them don't match, the matrices are not equal
                    return false
                }
            }
        }
        
        // If we reach this, all entries are equal
        return true
        
    }

}
