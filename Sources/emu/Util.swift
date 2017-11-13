/// A file containing useful utility functions

// Power operator
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

// Cross-platform rng support
#if os(Linux)
@_exported import Glibc
func randInt(_ max: Int) -> Int {
	return Int(random()%max)
}
#else
@_exported import Darwin.C
func randInt(_ max: Int) -> Int {
	return Int(arc4random_uniform(UInt32(max)))
}
#endif