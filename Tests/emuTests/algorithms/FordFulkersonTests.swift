import XCTest
@testable import emu

class fordFulkersonTests: XCTestCase {

    static var allTests = [
        ("testExampleDiagInt", testExampleDiagInt),
        ("testExampleDiagDouble", testExampleDiagDouble)
    ]
    
    func testExampleDiagInt() {

		let s = [1, 2, 8]
		let t = [1, 7, 3]
		let m = Matrix(diag: [1, 2, 3], def: 0)
		let res = FordFulkerson(source: s, mid: m, sink: t)
		XCTAssertEqual(res, m);
		
    }
    
    func testExampleDiagDouble() {

		let s = [1.2, 2.0, 8.8]
		let t = [1.0, 7.3, 3.0]
		let m = Matrix(diag: [1.0, 2.0, 3.0], def: 0.0)
		let res = FordFulkerson(source: s, mid: m, sink: t)
		XCTAssertEqual(res, m);
		
    }
	
}
