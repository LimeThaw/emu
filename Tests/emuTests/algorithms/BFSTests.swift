import XCTest
@testable import emu

class bfsTests: XCTestCase {

    static var allTests = [
        ("testTrivialExample", testTrivialExample),
        ("testLoopExample", testLoopExample),
        ("testfail", testfail),
    ]
    
    func testTrivialExample() {
		let m = Matrix<Double>(diag: [0, 0], def: 1)
		XCTAssertEqual(BFS(adjacency: m, source: 0, sink: 1), [0, 1]);
    }
    
    func testLoopExample() {
		var m = Matrix<Double>(h: 4, w: 4, value: 0)
		m[0, 1] = 1.0
		m[1, 2] = 1.0
		m[2, 1] = 1.0
		m[2, 3] = 1.0
		XCTAssertEqual(BFS(adjacency: m, source: 0, sink: 3), [0, 1, 2, 3]);
    }
    
    func testfail() {
		let m = Matrix<Double>(h: 3, w: 3, value: 0)
		XCTAssertNil(BFS(adjacency: m, source: 0, sink: 2));
    }
	
}
