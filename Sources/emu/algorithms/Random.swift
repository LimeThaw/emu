//
//  Random.swift
//  emu
//
//  Created by Tierry Hörmann on 15.11.17.
//

import Dispatch

/**
 ## Overview
 This protocol abstracts pseudo random number generators.
 
 ## Conforming to the Random protocol
 To conform to this protocol, the function `next() -> UInt64` must be implemented.
 All other functions provide default implementations.
 However for performance reasons,
 a custom random number generator might feel the need to override the default behavior for performance reasons.
 */
public protocol Random {
    
    /**
     A initializer that creates a new pseudo random number generator with an arbitrary seed.
     */
    init()
    
    /**
     A initializer that creates a new pseudo random number generator from the given seed.
     - parameter seed: The initial seed of the created pseudo random number generator
     */
    init(seed: UInt64)
    
    /**
     Returns the next random 64-bit wide unsigned integer.
     - returns: The next random 64-bit wide unsigned integer.
     */
    mutating func next() -> UInt64
    
    /**
     Returns the next random integer
     - returns: The next random integer.
     */
    mutating func next() -> Int
    
    /**
     Returns a random unsigned integer in the range of `[0, max)`.
     - parameter max: The upper bound (exclusive) of the possible range of the returned random integer.
     - returns: A random unsigned integer in the range of `[0, max)`.
     */
    mutating func next(max: UInt64) -> UInt64
    
    /**
     Returns a random integer in the range `[min, max)`.
     */
    mutating func next(min: Int, max: Int) -> Int
}

public extension Random {
    init() {
        self.init(seed: DispatchTime.now().uptimeNanoseconds)
    }
    
    mutating func next() -> Int {
        return Int(truncatingIfNeeded: next() % UInt64(Int.max))
    }
    
    mutating func next(max: UInt64) -> UInt64 {
        return next() % max
    }
    
    mutating func next(min: Int, max: Int) -> Int {
        return min + Int(truncatingIfNeeded: next(max: UInt64(max-min)))
    }
}
