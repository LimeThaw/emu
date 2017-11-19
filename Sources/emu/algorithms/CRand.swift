//
//  CRand.swift
//  emu
//
//  Created by Tierry Hörmann on 17.11.17.
//

/**
 A simple random number generator based on the C implementation of `rand`.
 */
public struct CRand: Random {
    
    /**
     The current random number
     */
    var cur: UInt64
    
    public init(seed: UInt64) {
        cur = seed
    }
    
    public mutating func next() -> UInt64 {
        cur = 1103515245 &* cur &+ 12345
        return cur
    }
}
