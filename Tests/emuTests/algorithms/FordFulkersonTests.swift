import XCTest
@testable import emu

class fordFulkersonTests: XCTestCase {

    static var allTests = generalTests + bipartiteTests
    
    static let generalTests = [
        ("testLoop", testLoop),
        ("testDisconnected", testDisconnected),
    ]
    
    func testLoop() {
        var caps = Matrix(h:4, w: 4, value: 0)
        caps[0, 1] = 1
        caps[1, 2] = 1
        caps[2, 1] = 1
        caps[1, 3] = 1
        let res = FordFulkerson(caps: caps, source: 0, sink: 3)
        var exp = Matrix(h:4, w: 4, value: 0)
        exp[0, 1] = 1
        exp[1, 3] = 1
        XCTAssertEqual(res.0, 1)
        XCTAssertEqual(res.1, exp)
    }
    
    func testDisconnected() {
        var caps = Matrix(h:4, w: 4, value: 0)
        caps[0, 1] = 1
        caps[2, 1] = 1
        caps[2, 3] = 1
        let res = FordFulkerson(caps: caps, source: 0, sink: 3)
        let exp = Matrix(h:4, w: 4, value: 0)
        XCTAssertEqual(res.0, 0)
        XCTAssertEqual(res.1, exp)
    }
        
        
    
    // Tests for the bipartite version of the algorithm
    static let bipartiteTests = [
        ("testExampleDiagInt", testExampleDiagInt),
        ("testExampleDiagDouble", testExampleDiagDouble),
        ("testExampleGreedy", testExampleGreedy)
    ]
    
    // Testing  simple diagonal int-valued matrix
    func testExampleDiagInt() {

		let s = [1, 2, 8]
		let t = [1, 7, 3]
		let m = Matrix(diag: [1, 2, 3], def: 0)
		let res = FordFulkersonBipartite(source: s, mid: m, sink: t)
		XCTAssertEqual(res.0, 6);
		XCTAssertEqual(res.1, m);
		
    }
    
    // Testing  simple diagonal double-valued matrix
    func testExampleDiagDouble() {

		let s = [1.2, 2.0, 8.8]
		let t = [1.0, 7.3, 3.0]
		let m = Matrix(diag: [1.0, 2.0, 3.0], def: 0.0)
		let res = FordFulkersonBipartite(source: s, mid: m, sink: t)
		XCTAssertEqual(res.0, 6.0);
		XCTAssertEqual(res.1, m);
		
    }
    
    // Testing a case where a greedy approach fails
    func testExampleGreedy() {
    
        let s = [2, 1]
        let t = [2, 1]
        var m = Matrix(h: 2, w: 2, value: 0)
        m[0, 0] = 2
        m[0, 1] = 1
        m[1, 0] = 1
		let res = FordFulkersonBipartite(source: s, mid: m, sink: t)
		let should = Matrix(diag: [1, 0], def:1)
		XCTAssertEqual(res.0, 3);
		XCTAssertEqual(res.1, should);
		
    }
	
}
