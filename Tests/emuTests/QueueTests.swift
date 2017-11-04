//
//  QueueTests.swift
//  emuTests
//
//  Created by Tierry Hörmann on 04.11.17.
//

import XCTest
@testable import emu

class QueueTests: XCTestCase {
    
    static var allTests = [
        ("testSimpleInOut", testSimpleInOut),
        ("testInOut", testInOut),
        ("testCount", testCount)
    ]
    
    /// the test array for the following tests
    let test = [1,2,3]
    
    /// Tests for simple enqueue and dequeue
    func testSimpleInOut() {
        var q = Queue<Int>()
        var out: [Int] = []
        for i in test {
            q.enqueue(i)
        }
        for _ in 0..<test.count {
            if let ret = q.dequeue() {
                out.append(ret)
            } else {
                XCTFail()
            }
        }
        XCTAssertEqual(test, out)
    }
    
    /// Tests for special cases in enqueuing and dequeuing
    func testInOut() {
        var q = Queue<Int>()
        q.enqueue(1)
        XCTAssertEqual(q.dequeue(), 1)
        q.enqueue(2)
        q.enqueue(3)
        XCTAssertEqual(q.dequeue(), 2)
        q.enqueue(4)
        XCTAssertEqual(q.dequeue(), 3)
        XCTAssertEqual(q.dequeue(), 4)
        XCTAssertEqual(q.dequeue(), nil)
    }
    
    /// Tests the count and isEmpty property
    func testCount() {
        var q = Queue<Int>()
        XCTAssert(q.isEmpty)
        q.enqueue(1)
        XCTAssertEqual(q.count, 1)
        q.enqueue(2)
        XCTAssertEqual(q.count, 2)
        q.dequeue()
        XCTAssertEqual(q.count, 1)
        q.enqueue(3)
        XCTAssertEqual(q.count, 2)
        q.dequeue()
        q.dequeue()
        XCTAssert(q.isEmpty)
        q.dequeue()
        XCTAssert(q.isEmpty)
    }
    
    /// Tests the sequence functionality
    func testSequence() {
        var out: [Int] = []
        var q = Queue<Int>()
        // first test on empty queue
        for _ in q {
            XCTFail()
        }
        // now test on filled queue
        for i in test {
            q.enqueue(i)
        }
        for i in q {
            out.append(i)
        }
        XCTAssertEqual(test, out)
    }
}
