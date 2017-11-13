import XCTest
@testable import emuTests

XCTMain([
    testCase(insertionSortTests.allTests),
    testCase(QueueTests.allTests),
    testCase(PFAVLTree.allTests),
    testCase(quicksortTests.allTests)
])
