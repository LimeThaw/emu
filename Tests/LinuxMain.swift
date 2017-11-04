import XCTest
@testable import emuTests

XCTMain([
    testCase(selectionSortTests.allTests),
    testCase(QueueTests.allTests)
])
