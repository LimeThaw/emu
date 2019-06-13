/**
 A simple container for a 2 dimensional matrix of constant size with numeric values.
 All matrices are row-major, so the first coordinate indexes the row, and the second
 indexes the column.
 */
public struct Matrix<T: Numeric> {

    /// The size of the matrix
    let size: (Int, Int)
    /// The values in the matrix
    private var data: [[T]]
    
    /// Default initializer, creating a matrix where every entry is a given default value
    init(h: Int, w: Int, value: T) {
        size = (h, w)
        data = Array(repeating: Array(repeating: value, count: w), count: h)
    }
    
    /**
     Subscript operator for getting and setting values in the matrix.
     If the indexes are out of range, the operator will return nil or ignore the
     assignment and print a warning.
     */
    subscript(_ x: Int, _ y: Int) -> T? {
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
                print("Matrix index out of range: [\(x), \(y)]")
                //Thread.callStackSymbols.forEach{print($0)}
            }
        }
    }

}
