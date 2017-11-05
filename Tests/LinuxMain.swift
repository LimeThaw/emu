import XCTest
@testable import emuTests

XCTMain([
    testCase(insertionSortTests.allTests),
    testCase(QueueTests.allTests)
])
