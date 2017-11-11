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
            ("test_height", test_height)
        ]
    }()
    #endif
    
    // test trees
    let empty: PFAVLTree<Int> = .Leaf
    let one: PFAVLTree<Int> = .Node(0, .Leaf, .Leaf, 1)
    let two: PFAVLTree<Int> = .Node(1, .Node(0, .Leaf, .Leaf, 1), .Leaf, 2)
    let unbalanced1: PFAVLTree<Int> = .Node(2,
                                            .Leaf,
                                            .Node(1, .Node(0, .Leaf, .Leaf, 1), .Leaf, 2),
                                            3)
    let unbalanced2: PFAVLTree<Int> = .Node(0,
                                            .Leaf,
                                            .Node(2, .Node(1, .Leaf, .Leaf, 1), .Leaf, 2),
                                            3)
    
    lazy var all = [empty, one, two, unbalanced1, unbalanced2]
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
        XCTAssert(empty2 == empty)
        let one2 = PFAVLTree<Int>(0, l: empty2, r: empty2)
        XCTAssert(one2 == one)
    }
    
    /**
     Tests the height property.
     */
    func test_height() {
        XCTAssert(empty.height == 0)
        XCTAssert(one.height == 1)
        XCTAssert(two.height == 2)
        XCTAssert(unbalanced1.height == 3)
        XCTAssert(unbalanced2.height == 3)
    }
}
