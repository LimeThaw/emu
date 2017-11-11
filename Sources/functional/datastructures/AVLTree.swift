//
//  AVLTree.swift
//
//  Created by Tierry Hörmann on 21.03.17.
//
//

/**
 A purely functional implementation of an [AVL tree](https://en.wikipedia.org/wiki/AVL_tree).
 */
public enum PFAVLTree<T: Comparable>: Equatable {
    /// A leaf contains no value and has height zero
    case Leaf
    /**
     A node contains a value, a left subtree, a right subtree and a height.
     */
    indirect case Node(T, PFAVLTree<T>, PFAVLTree<T>, Int)

    /**
     Creates a empty AVL tree (a leaf).
     */
    public init(){
        self = .Leaf
    }

    /**
     Creates a AVL tree with a given root value and a left and a right subtree.
     - parameter val: The root value of this tree.
     - parameter l: The left subtree.
     - parameter r: The right subtree.
     */
    public init(_ val: T, l: PFAVLTree<T>, r: PFAVLTree<T>){
        self = .Node(val, l, r, max(l.height(), r.height())+1)
    }

    /// The root value of this tree.
    public var value: T? {
        switch self {
        case .Leaf:
            return nil
        case let .Node(val, _, _, _):
            return val
        }
    }

    /**
     Returns whether this tree contains the given value or not.
     - parameter val: The value to look for.
     - returns: `true` if this tree contains `val`, `false` otherwise.
     */
    public func contains(_ val: T) -> Bool {
        return find(val) != nil
    }

    /**
     Searches for a given value and returns it if it is found.
     - parameter val: The value to search for.
     - returns: The value in this tree, that is equal to `val`, or `nil` if there is no such value.
     */
    public func find(_ val: T) -> T? {
        switch self {
        case let .Node(v, l, r, _):
            if v == val {
                return v
            } else if val < v {
                return l.find(val)
            } else {
                return r.find(val)
            }
        default:
            return nil
        }
    }

    /// The smallest value in this tree.
    public var smallest: T? {
        return removeSmallest().0
    }

    /// The largest value in this tree.
    public var largest: T? {
        return removeLargest().0
    }

    /**
     Removes the smallest value from this tree and returns it.
     - returns: A tuple with the smallest value of this tree as its first argument,
     and the new tree without this value as its second argument.
     If this tree is a leaf, then `(nil, .Leaf)` is returned.
     */
    public func removeSmallest() -> (T?, PFAVLTree<T>) {
        switch self {
        case let .Node(v, l, r, _):
            let next = l.removeSmallest()
            let retTree = {next.0 == nil ? r : PFAVLTree<T>(v, l: next.1, r: r)}
            let retVal = next.1 == .Leaf ? v : next.0
            return (retVal, retTree().balance())
        case .Leaf:
            return (nil, .Leaf)
        }
    }

    /**
     Removes the largest value from this tree and returns it.
     - returns: A tuple with the largest value of this tree as its first argument,
     and the new tree without this value as its second argument.
     If this tree is a leaf, then `(nil, .Leaf)` is returned.
     */
    public func removeLargest() -> (T?, PFAVLTree<T>) {
        switch self {
        case let .Node(v, l, r, _):
            let next = r.removeLargest()
            let retTree = next.0 == nil ? l : PFAVLTree<T>(v, l: l, r: next.1)
            let retVal = next.1 == .Leaf ? v : next.0
            return (retVal, retTree.balance())
        case .Leaf:
            return (nil, .Leaf)
        }
    }

    /**
     The height of this tree.
     For a leaf, height = 0 and for a node, height = 1+max(height(l), height(r)),
     where l indicates the left subtree of the node and r indicates the right subtree of the node.
     */
    public var height: Int {
        switch self {
        case .Leaf:
            return 0
        case let .Node(_, _, _, b):
            return b
        }
    }

    /// The balance of this tree, wrapped as a `BalanceType`.
    private var balanceType: BalanceType {
        return BalanceType(balance)
    }

    /**
     The balance of this tree, which is height(r) - height(l),
     where l indicates the left subtree of the node and r indicates the right subtree of the node.
     */
    private var balance: Int {
        switch self {
        case let .Node(_, l, r, _):
            return r.height-l.height
        case .Leaf:
            return 0
        }
    }

    /**
     Rotates this tree once to the right.
     - returns: The rotated tree.
     */
    private func rotateRight() -> PFAVLTree<T> {
        switch self {
        case .Leaf:
            return self
        case let .Node(v, l, r, _):
            let newL = l.balance > 0 ? l.rotateLeft() : l
            switch newL {
            case let .Node(vl, ll, rl, _):
                let nuR = PFAVLTree<T>(v, l: rl, r: r)
                return PFAVLTree<T>(vl, l: ll, r: nuR)
            case .Leaf:
                assert(false)
                return self
            }
        }
    }

    /**
     Rotates this tree once to the left.
     - returns: The rotated tree.
     */
    private func rotateLeft() -> PFAVLTree<T> {
        switch self {
        case let .Node(v, l, r, _):
            let newR = r.balance < 0 ? r.rotateRight() : r
            switch newR {
            case let .Node(vr, lr, rr, _):
                let nuL = PFAVLTree<T>(v, l: l, r: lr)
                return PFAVLTree<T>(vr, l: nuL, r: rr)
            default:
                assert(false)
                return self
            }
        case .Leaf:
            return self
        }
    }

    /**
     Rotates this tree to the right or to the left, such that it is in a centered balance afterwards,
     i.e. |height(l)-height(r)| <= 1,
     where l indicates the left subtree of the node and r indicates the right subtree of the node.
     - returns: The rebalanced tree.
     */
    private func rebalance() -> PFAVLTree<T> {
        switch self {
        case .Leaf:
            return self
        case .Node:
            switch balanceType as BalanceType {
            case .Center:
                return self
            case .Left:
                return rotateRight()
            case .Right:
                return rotateLeft()
            }
        }
    }

    /**
     Inserts a value into this tree.
     If a equal value to `val` is already contained in this tree, it gets replaced by `val`.
     - parameter val: The value to insert.
     - returns: The new tree that contains `val`.
     */
    public func insert(_ val: T) -> PFAVLTree<T> {
        switch self {
        case .Leaf:
            return .Node(val, .Leaf, .Leaf, 1)
        case let .Node(v, l, r, _):
            let newL = val < v ? l.insert(val) : l
            let newR = val > v ? r.insert(val) : r
            let n = v == val ? self : PFAVLTree<T>(v, l: newL, r: newR)
            return n.rebalance()
        }
    }

    /**
     Removes a value from this tree, or does nothing if this tree does not contain `val`.
     - parameter val: The value to remove.
     - returns: The new tree that does not contain `val` anymore.
     */
    public func remove(_ val: T) -> PFAVLTree<T> {
        switch self {
        case .Leaf:
            return self
        case let .Node(v, l, r, _):
            if v == val {
                let lh = l.height
                let rh = r.height
                if lh == 0 && rh == 0 {
                    return .Leaf
                }
                if lh > rh {
                    let delL = l.removeLargest()
                    return PFAVLTree<T>(delL.0!, l: delL.1, r: r).rebalance()
                } else {
                    let delR = r.removeSmallest()
                    return PFAVLTree<T>(delR.0!, l: l, r: delR.1).rebalance()
                }
            } else if val > v {
                return PFAVLTree<T>(v, l: l, r: r.remove(val))
            } else {
                return PFAVLTree<T>(v, l: l.remove(val), r: r)
            }
        }
    }
}

public func ==<T>(lhs: PFAVLTree<T>, rhs: PFAVLTree<T>) -> Bool {
    switch (lhs, rhs) {
    case (.Leaf, .Leaf):
        return true
    case (let .Node(v1, l1, r1, _), let .Node(v2, l2, r2, _)):
        return v1 == v2 && l1 == l2 && r1 == r2;
    default:
        return false
    }
}

/**
 This enum cathegorizes a trees balance into 3 groups: Left, Center and Right.
 Left means, that the left height is at least by two larger than the right height,
 Right means, that the right height is at least by two larger than the left height
 and Center means, that the left and right height only differ by at most one.
 */
private enum BalanceType {
    case Left, Center, Right
    /**
     Creates a `BalanceType` from a given balance.
     - parameter arg: The balance of the tree whose `BalanceType` is requested.
     */
    init(_ arg: Int) {
        self = arg < -1 ? .Left : arg > 1 ? .Right : .Center
    }
}
