/**
 A queue is a datastructure, which upholds the FIFO policy.
 This means, that for any two elements A and B, if A is enqueued before B, then A is also dequeued before B.
 Enqueuing element A means for this datastructure, that A is inserted into the datastructure and dequeuing A means removing A from this datastructure.
 */
public struct Queue<T>: Sequence {
    /// The first node in this queue or `nil` if it does not have a last node
    fileprivate var first: QNode<T>?
    /// The last node in this queue or `nil` if it does not have a last node
    fileprivate var last: QNode<T>?
    /// The number of items this queue holds
    public private(set) var count = 0
    /**
     Returns whether this queue contains a item or not.
     - returns: `true` if this queue does not contain an item, `false` otherwise
     */
    public var isEmpty: Bool {
        get { return count == 0 }
    }

    /**
     Enqueues an element into this queue.
     - parameter val: The element that should be enqueued.
     */
    public mutating func enqueue(_ val: T) {
        if isEmpty {
            first = QNode<T>(val: val, next: nil, prev: nil)
            last = first
        } else {
            let l = QNode<T>(val: val, next: last!, prev: nil)
            last!.prev = l
            last = l
        }
        count += 1
    }
	
    /**
     Dequeues an element from this queue.
     - returns: The dequeued element.
     */
    @discardableResult
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        let f = first!
        first = f.prev
        if first != nil {
            first!.next = nil
        } else {
            last = nil
        }
        count -= 1
        return f.val
    }
    
    /**
     Creates an iterator to iterate over the elements of this queue.
     - returns: A iterator to iterate over the elements of this queue.
     */
    public func makeIterator() -> QueueIterator<T> {
        return QueueIterator<T>(self)
    }
}

/// A iterator for iterating over the elements of a queue.
public struct QueueIterator<T>: IteratorProtocol {
    /// The underlying queue of this iterator.
    private var queue: Queue<T>
    /**
     Creates a iterator from a given queue.
     - parameter q: The queue over which the created iterator should run.
     */
    public init(_ q: Queue<T>) {
        queue = q
    }
    
    public mutating func next() -> T? {
        return queue.dequeue()
    }
}


/// The node of a queue
private class QNode<T> {
    /// The value of the node
    let val: T
    /// The next node
    var next: QNode<T>?
    /// The previous node
    weak var prev: QNode<T>?
    /**
     Creates a new node
     - parameter val: the value of this node
     - parameter next: the next node or `nil` if it does not have a next node
     - parameter prev: the previous node or `nil` if it does not have a previous node
     */
    init(val: T, next: QNode<T>?, prev: QNode<T>?) {
        self.val = val
        self.next = next
    }
}
