import XCTest
@testable import emu

class fordFulkersonTests: XCTestCase {

    static var allTests = [
        ("testExampleDiagInt", testExampleDiagInt)
    ]
    
    func testExampleDiagInt() {

		let s = [1, 2, 3]
		let t = [1, 2, 3]
		let m = Matrix(diag: [1, 2, 3], def: 0)
		let res = FordFulkerson(source: s, mid: m, sink: t)
		XCTAssertEqual(res, m);
    }
	
}
