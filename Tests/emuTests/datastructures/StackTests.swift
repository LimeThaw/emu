import XCTest
@testable import emu

class StackTests: XCTestCase {
    
    static var allTests = [
        ("testDefaultInitAndPoppingEmpty", testDefaultInitAndPoppingEmpty),
        ("testArrayInit", testArrayInit),
        ("testPushPop", testPushPop),
        ("testPeek", testPeek),
        ("testReverse", testReverse),
        ("testEquality", testEquality),
        ("testInequality", testInequality)
    ]
    
    /// Tests for initialization an popping from empty stack
    func testDefaultInitAndPoppingEmpty() {
        var m = Stack<Int>()
        XCTAssertEqual(m.count, 0)
        XCTAssertEqual(m.pop(), nil)
        XCTAssertEqual(m.count, 0)
    }
    func testArrayInit() {
        let arr = [4.20, 6.9]
        var m = Stack(data: arr)
        XCTAssertEqual(m.count, 2)
        XCTAssertEqual(m.pop(), 6.9)
        XCTAssertEqual(m.count, 1)
        XCTAssertEqual(m.pop(), 4.20)
        XCTAssertEqual(m.count, 0)
        XCTAssertEqual(m.pop(), nil)
    }
    
    // Tests push/pop
    func testPushPop() {
        var s = Stack<Int>()
        s.push(1)
        XCTAssertEqual(s.count, 1)
        XCTAssertEqual(s.pop(), 1)
        s.push(2)
        s.push(3)
        XCTAssertEqual(s.pop(), 3)
        XCTAssertEqual(s.count, 1)
    }

    func testPeek() {
        let s = Stack(data: [12])
        XCTAssertEqual(s.count, 1)
        XCTAssertEqual(s.peek(), 12)
        XCTAssertEqual(s.count, 1)
    }

    func testReverse() {
        var s = Stack(data: [1, 2, 3, 4])
        s.reverse()
        XCTAssertEqual(s.pop(), 1)
        XCTAssertEqual(s.pop(), 2)
        XCTAssertEqual(s.pop(), 3)
        XCTAssertEqual(s.pop(), 4)
        XCTAssertEqual(s.pop(), nil)
    }

    func testEquality() {
        let s1 = Stack(data: [1, 2, 3, 4])
        let s2 = Stack(data: [1, 2, 3, 4])
        XCTAssertEqual(s1 == s2, true)
        XCTAssertEqual(s2 == s1, true)
    }

    func testInequality() {
        let s1 = Stack(data: [1, 2, 3, 4])
        let s2 = Stack(data: [4, 3, 2, 1])
        XCTAssertEqual(s1 == s2, false)
        XCTAssertEqual(s2 == s1, false)
    }

    func testSubscript() {
        let s = Stack(data: [1, 2, 3, 4, 5])
        XCTAssertEqual(s[0], 1)
        XCTAssertEqual(s[4], 5)
        XCTAssertEqual(s[5], nil)
        XCTAssertEqual(s[-1], nil)
    }
}
