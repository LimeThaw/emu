import XCTest
@testable import emu

class MatrixTests: XCTestCase {
    
    static var allTests = [
        ("testSimpleDefaultInit", testSimpleDefaultInit),
        ("testSimpleSubscript", testSimpleSubscript)
    ]
    
    /// Tests for the default initialization
    func testSimpleDefaultInit() {
        var m = Matrix(h: 3, w: 3, value: 0.5)
        XCTAssertEqual(m[1, 1], 0.5)
        m[1, 1] = 3
    }
    
    // Tests the functionality of the subscript notation
    func testSimpleSubscript() {
        var m = Matrix(h: 3, w: 3, value: 0.5)
        m[1, 1] = 3
        XCTAssertEqual(m[1, 1]!, 3)
        m[0, 0] = 246
        XCTAssertEqual(m[0, 0]!, 246)
        m[3, 3] = 444
        XCTAssertEqual(m[3, 3], nil)
    }
}
