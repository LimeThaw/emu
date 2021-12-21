public struct Stack<T: Equatable> : Equatable {

    private(set) var count = 0
    private var data = Array<T>()

    public init() {}

    public init(data a_data: Array<T>) {
        data = a_data
        count = a_data.count
    }

    public mutating func push(_ arg: T) {
        data.append(arg)
        count = data.count
    }

    public mutating func pop() -> T? {
        if self.count == 0 {
            return nil
        } else {
            let ret = data.removeLast()
            count = data.count
            return ret
        }
    }

    public func peek() -> T? {
        if self.count == 0 {
            return nil
        } else {
            return data[self.count-1]
        }
    }

    public mutating func reverse() {
        data.reverse()
    }

    public subscript(_ i: Int) -> T? {
        get {
            if 0<=i && i<count {
                return data[i]
            } else {
                return nil
            }
        }
    }

    public static func == (lhs: Stack<T>, rhs: Stack<T>) -> Bool {
        if lhs.count != rhs.count {
            return false
        } else {
            for i in 0..<lhs.count {
                if lhs[i] != rhs[i] {
                    return false
                }
            }
        }
        return true
    }

}