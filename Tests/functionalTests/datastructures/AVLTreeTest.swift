import XCTest
@testable import functional

/**
 Tests for the purely functional AVLTree
 */
class PFAVLTreeTest : XCTestCase {
    #if os(Linux)
    static var allTests = {
       return [
            ("test_equals", test_equals),
            ("test_init", test_init),
            ("test_height", test_height),
            ("test_value", test_value),
            ("test_find", test_find),
            ("test_contains", test_contains),
            ("test_balance", test_balance),
            ("test_rotate", test_rotate),
            ("test_rebalance", test_rebalance),
            ("test_smallest", test_smallest),
            ("test_largest", test_largest),
            ("test_removeSmallest", test_removeSmallest),
            ("test_removeLargest", test_removeLargest),
            ("test_insert", test_insert),
            ("test_remove", test_remove)
        ]
    }()
    #endif
    
    // test trees
    let empty: PFAVLTree<Int> = .Empty
    let one: PFAVLTree<Int> = .Node(0, .Empty, .Empty, 1)
    let two: PFAVLTree<Int> = .Node(1, .Node(0, .Empty, .Empty, 1), .Empty, 2)
    let twoRight: PFAVLTree<Int> = .Node(0, .Empty, .Node(1, .Empty, .Empty, 1), 2)
    let unbalanced1: PFAVLTree<Int> = .Node(2,
                                            .Node(1, .Node(0, .Empty, .Empty, 1), .Empty, 2),
                                            .Empty,
                                            3)
    let unbalanced2: PFAVLTree<Int> = .Node(0,
                                            .Empty,
                                            .Node(2, .Node(1, .Empty, .Empty, 1), .Empty, 2),
                                            3)
    
    lazy var all = [empty, one, two, twoRight, unbalanced1, unbalanced2]
    lazy var balanced = [empty, one, two]
    lazy var unbalanced = [unbalanced1, unbalanced2]
    
    /**
     Tests equals operator
     */
    func test_equals() {
        for i in 0..<all.count {
            for j in 0..<all.count {
                XCTAssert((all[i] == all[j]) == (i == j))
            }
        }
    }
    
    /**
     Tests the initializer
     */
    func test_init() {
        let empty2 = PFAVLTree<Int>()
        XCTAssertEqual(empty2, empty)
        let one2 = PFAVLTree<Int>(0, l: empty2, r: empty2)
        XCTAssertEqual(one2, one)
    }
    
    /**
     Tests the height property.
     */
    func test_height() {
        XCTAssertEqual(empty.height, 0)
        XCTAssertEqual(one.height, 1)
        XCTAssertEqual(two.height, 2)
        XCTAssertEqual(unbalanced1.height, 3)
        XCTAssertEqual(unbalanced2.height, 3)
    }
    
    /**
     Tests the value property
     */
    func test_value() {
        XCTAssertEqual(empty.value, nil)
        XCTAssertEqual(one.value!, 0)
        XCTAssertEqual(two.value!, 1)
        XCTAssertEqual(unbalanced1.value!, 2)
        XCTAssertEqual(unbalanced2.value!, 0)
    }
    
    /**
     Tests the find function
     */
    func test_find() {
        XCTAssertEqual(empty.find(1), nil)
        XCTAssertEqual(one.find(0), 0)
        XCTAssertEqual(one.find(1), nil)
        XCTAssertEqual(two.find(0), 0)
        XCTAssertEqual(two.find(1), 1)
        XCTAssertEqual(two.find(-1), nil)
        XCTAssertEqual(unbalanced2.find(-1), nil)
        XCTAssertEqual(unbalanced2.find(1), 1)
    }
    
    /**
     Tests the contains function
     */
    func test_contains() {
        XCTAssert(!empty.contains(1))
        XCTAssert(one.contains(0))
        XCTAssert(!one.contains(-1))
        XCTAssert(!unbalanced2.contains(5))
        XCTAssert(unbalanced2.contains(1))
    }
    
    /**
     Tests the internal balance property
     */
    func test_balance() {
        XCTAssertEqual(empty.balance, 0)
        XCTAssertEqual(one.balance, 0)
        XCTAssertEqual(two.balance, -1)
        XCTAssertEqual(twoRight.balance, 1)
        XCTAssertEqual(unbalanced1.balance, -2)
        XCTAssertEqual(unbalanced2.balance, 2)
    }
    
    /**
     Tests the internal rotateRight and rotateLeft functions
     */
    func test_rotate() {
        XCTAssertEqual(empty.rotateLeft(), empty)
        XCTAssertEqual(empty.rotateRight(), empty)
        XCTAssertEqual(one.rotateLeft(), empty)
        XCTAssertEqual(one.rotateRight(), empty)
        XCTAssertEqual(two.rotateLeft(), empty)
        XCTAssertEqual(two.rotateRight(), twoRight)
        XCTAssertEqual(twoRight.rotateLeft(), two)
        XCTAssertEqual(twoRight.rotateRight(), empty)
        XCTAssertEqual(unbalanced1.rotateLeft(), empty)
        var res = unbalanced1.rotateRight()
        XCTAssertEqual(res.height, 2)
        XCTAssertEqual(res.value, 1)
        res = unbalanced2.rotateLeft()
        XCTAssertEqual(res.height, 2)
        XCTAssertEqual(res.value, 1)
        XCTAssertEqual(unbalanced2.rotateRight(), empty)
    }
    
    /**
     Tests the internal rebalance function
     */
    func test_rebalance() {
        XCTAssertEqual(empty.rebalance(), empty)
        XCTAssertEqual(one.rebalance(), one)
        XCTAssertEqual(two.rebalance(), two)
        XCTAssertEqual(twoRight.rebalance(), twoRight)
        var res = unbalanced1.rebalance()
        XCTAssertEqual(res.height, 2)
        XCTAssertEqual(res.value, 1)
        res = unbalanced2.rebalance()
        XCTAssertEqual(res.height, 2)
        XCTAssertEqual(res.value, 1)
    }
    
    /**
     Tests for smallest key query
     */
    func test_smallest() {
        XCTAssertEqual(empty.smallest, nil)
        XCTAssertEqual(one.smallest, 0)
        XCTAssertEqual(two.smallest, 0)
        XCTAssertEqual(twoRight.smallest, 0)
        XCTAssertEqual(unbalanced1.smallest, 0)
        XCTAssertEqual(unbalanced2.smallest, 0)
    }
    
    /**
     Tests for largest key query
     */
    func test_largest() {
        XCTAssertEqual(empty.largest, nil)
        XCTAssertEqual(one.largest, 0)
        XCTAssertEqual(two.largest, 1)
        XCTAssertEqual(twoRight.largest, 1)
        XCTAssertEqual(unbalanced1.largest, 2)
        XCTAssertEqual(unbalanced2.largest, 2)
    }
    
    /**
     Tests for smallest key removal
     */
    func test_removeSmallest() {
        XCTAssertEqual(empty.removeSmallest().0, nil)
        XCTAssertEqual(empty.removeSmallest().1, empty)
        XCTAssertEqual(one.removeSmallest().0, 0)
        XCTAssertEqual(one.removeSmallest().1, empty)
        XCTAssertEqual(two.removeSmallest().0, 0)
        XCTAssertEqual(two.removeSmallest().1, .Node(1, .Empty, .Empty, 1))
        XCTAssertEqual(twoRight.removeSmallest().0, 0)
        XCTAssertEqual(twoRight.removeSmallest().1, .Node(1, .Empty, .Empty, 1))
        XCTAssertEqual(unbalanced1.removeSmallest().0, 0)
        XCTAssertEqual(unbalanced1.removeSmallest().1, .Node(2, .Node(1, .Empty, .Empty, 1), .Empty, 2))
        XCTAssertEqual(unbalanced2.removeSmallest().0, 0)
        XCTAssertEqual(unbalanced2.removeSmallest().1, .Node(2, .Node(1, .Empty, .Empty, 1), .Empty, 2))
    }
    
    /**
     Tests for largest key removal
     */
    func test_removeLargest() {
        XCTAssertEqual(empty.removeLargest().0, nil)
        XCTAssertEqual(empty.removeLargest().1, empty)
        XCTAssertEqual(one.removeLargest().0, 0)
        XCTAssertEqual(one.removeLargest().1, empty)
        XCTAssertEqual(two.removeLargest().0, 1)
        XCTAssertEqual(two.removeLargest().1, .Node(0, .Empty, .Empty, 1))
        XCTAssertEqual(twoRight.removeLargest().0, 1)
        XCTAssertEqual(twoRight.removeLargest().1, .Node(0, .Empty, .Empty, 1))
        XCTAssertEqual(unbalanced1.removeLargest().0, 2)
        XCTAssertEqual(unbalanced1.removeLargest().1, .Node(1, .Node(0, .Empty, .Empty, 1), .Empty, 2))
        XCTAssertEqual(unbalanced2.removeLargest().0, 2)
        XCTAssertEqual(unbalanced2.removeLargest().1, .Node(0, .Empty, .Node(1, .Empty, .Empty, 1), 2))
    }
    
    /**
     Tests for key insertion
     */
    func test_insert() {
        XCTAssertEqual(empty.insert(0), one)
        XCTAssertEqual(one.insert(1), .Node(0, .Empty, .Node(1, .Empty, .Empty, 1), 2))
        XCTAssertEqual(two.insert(2), .Node(1, .Node(0, .Empty, .Empty, 1), .Node(2, .Empty, .Empty, 1), 2))
        XCTAssertEqual(two.insert(1), two)
        var res = two.insert(-1)
        XCTAssertEqual(res.value, 0)
        XCTAssertEqual(res.height, 2)
        XCTAssert(res.contains(-1))
        res = two.insert(2).insert(3).insert(4).insert(5)
        XCTAssertEqual(res.value, 3)
        XCTAssertEqual(res.height, 3)
        res = unbalanced1.insert(0) // just rebalances the tree
        XCTAssertEqual(res.height, 2)
        XCTAssert(res.contains(1) && res.contains(2) && res.contains(0))
        res = unbalanced2.insert(0) // again just rebalances the tree
        XCTAssertEqual(res.height, 2)
        XCTAssert(res.contains(1) && res.contains(2) && res.contains(0))
    }
    
    /**
     Tests for key removal
     */
    func test_remove() {
        XCTAssertEqual(empty.remove(0), empty)
        XCTAssertEqual(one.remove(0), empty)
        XCTAssertEqual(two.remove(1), one)
        XCTAssertEqual(two.remove(0), .Node(1, .Empty, .Empty, 1))
        XCTAssertEqual(two.remove(-1), two)
        var res = two.insert(-2).insert(-1).remove(1)
        XCTAssertEqual(res.value, -1)
        XCTAssertEqual(res.height, 2)
        XCTAssert(!res.contains(1))
        res = two.insert(2).insert(3).insert(4).insert(5).remove(3)
        XCTAssertEqual(res.height, 3)
        XCTAssert(res.value == 2 || res.value == 4) // tree is perfectly balanced, so either is allowed as root
        XCTAssert(!res.contains(3))
        res = two.insert(2).insert(-1).remove(2)
        XCTAssertEqual(res.value, 0)
        XCTAssertEqual(res.height, 2)
        XCTAssert(!res.contains(2))
    }
}
