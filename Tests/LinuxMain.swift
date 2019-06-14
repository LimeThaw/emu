import XCTest
@testable import emuTests
@testable import functionalTests
//@testable import threadsafeTests

XCTMain([
    testCase(fordFulkersonTests.allTests),
    testCase(insertionSortTests.allTests),
    testCase(QueueTests.allTests),
    testCase(MatrixTests.allTests),
    testCase(PFAVLTreeTests.allTests),
    testCase(quicksortTests.allTests)
])
