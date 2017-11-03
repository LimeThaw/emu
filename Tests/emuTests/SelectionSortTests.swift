import XCTest
@testable import emu

class selectionSortTests: XCTestCase {
    func simpleListTests() {

		let ordered = [1, 2, 3]

		// Ordered lists should stay ordered
		var l1 = [1, 2, 3]
        XCTAssertEqual(insertionSort(l1), ordered)
		inplaceInsertionSort(&l1)
		XCTAssertEqual(l1, ordered);

		var l2 = [3, 2, 1]
        XCTAssertEqual(insertionSort(l2), ordered)
		inplaceInsertionSort(&l2)
		XCTAssertEqual(l2, ordered);

		let ordered2 = [1, 1, 1, 2, 2, 2, 3, 3, 3]
		var l3 = [1, 2, 3, 3, 2, 1, 1, 2, 3]
        XCTAssertEqual(insertionSort(l3), ordered2)
		inplaceInsertionSort(&l3)
		XCTAssertEqual(l3, ordered2);
    }


    static var allTests = [
        ("SimpleListTests", simpleListTests),
    ]
}
