import XCTest
@testable import emuTests
@testable import functionalTests
//@testable import threadsafeTests

XCTMain([
    testCase(insertionSortTests.allTests),
    testCase(QueueTests.allTests),
    testCase(MatrixTests.allTests),
    testCase(StackTests.allTests),
    testCase(PFAVLTreeTests.allTests),
    testCase(quicksortTests.allTests),
    testCase(bfsTests.allTests),
    testCase(fordFulkersonTests.allTests),
])
