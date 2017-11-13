import XCTest
@testable import emuTests

XCTMain([
    testCase(insertionSortTests.allTests),
    testCase(quicksortTests.allTests),
    testCase(QueueTests.allTests)
])
