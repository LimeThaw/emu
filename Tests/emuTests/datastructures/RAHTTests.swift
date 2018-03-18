//
//  RAHTTests.swift
//  emuTests
//
//  Created by Tierry Hörmann on 25.02.18.
//

import XCTest
@testable import emu

class RAHTTests: XCTestCase {
    
    static var allTests = [
        ("testCount", testCount),
        ("testHas", testHas),
        ("testGet", testGet),
        ("testGetRandom", testGetRandom),
        ("testCustomGen", testCustomGen),
        ("testCollection", testCollection),
        ("testPerformance", testPerformance)
    ]
    
    var r: RAHT<Int> = RAHT()
    
    private func fillRAHT(from: Int = -10, to: Int = 10) {
        for x in from...to {
            r.insert(x)
        }
    }
    
    func testCount() {
        r = RAHT()
        XCTAssert(r.count == 0)
        fillRAHT()
        XCTAssert(r.count == 21)
        r.remove(10)
        XCTAssert(r.count == 20)
        r.remove(10)
        XCTAssert(r.count == 20)
    }
    
    func testHas() {
        r = RAHT()
        XCTAssertFalse(r.has(withHash: 0))
        fillRAHT()
        XCTAssert(r.has(withHash: 0) && r.has(withHash: 10) && r.has(withHash: -10) && r.has(withHash: 5))
        r.remove(10)
        XCTAssertFalse(r.has(withHash: 10))
        XCTAssert(r.has(withHash: 9))
    }
    
    func testGet() {
        r = RAHT()
        XCTAssert(r.get(fromHash: 0) == nil)
        fillRAHT()
        XCTAssert(r.get(fromHash: 10) == 10 && r.get(fromHash: 0) == 0)
        r.remove(10)
        XCTAssert(r.get(fromHash: 10) == nil)
    }
    
    func testGetRandom() {
        r = RAHT()
        XCTAssert(r.getRandom() == nil)
        let up = 5, lo = -5
        fillRAHT(from: lo, to: up)
        let entries = r.count
        let tries = 1000
        var range = Set(lo...up)
        for _ in 0..<tries {
            let res = r.getRandom()!
            XCTAssert(res <= up && res >= lo)
            range.remove(res)
        }
        XCTAssert(range.isEmpty, "RAHT picked only \(entries - range.count) different entries out of \(entries) entries after \(tries) calls of getRandom")
        while !r.isEmpty {
            r.remove(r.getRandom()!)
        }
    }
    
    func testCustomGen() {
        
    }
    
    func testCollection() {
        
    }
    
    func testPerformance() {
        
    }
}
