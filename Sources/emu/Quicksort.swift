// Created 2017-11-03 by LimeThaw

import XCTest

// Cross-platform rng support
#if os(Linux)
@_exported import Glibc
private func randInt(_ max: Int) -> Int {
	return Int(random()%max)
}
#else
@_exported import Darwin.C
private func randInt(_ max: Int) -> Int {
	return Int(arc4random_uniform(UInt32(max)))
}
#endif

/**
 *  Swaps two values in an array.
 *  - parameter arr:	The array containing the elements to swap
 *  - parameter ind1:	The index of the first element to swap
 *  - parameter ind2:	The index of the second element to swap
 */
private func swap<T>(_ arr: inout Array<T>, _ ind1: Int, _ ind2: Int) {
	// Make sure indices are in bounds
	XCTAssertTrue(
		0 <= ind1 &&
		0 <= ind2 &&
		ind1 < arr.count &&
		ind2 < arr.count
	)

	// Simple 3-way swap
	let tmp = arr[ind1]
	arr[ind1] = arr[ind2]
	arr[ind2] = tmp
}

/**
 *  Implements basic quicksort on an array of comparable objects.
 *  - parameter nums:	The array you want sorted
 *  - parameter cutoff: The minimal array length for which the algorithm recurses. If the array is
 *  						shorter, then it's sorted with inplaceInsertionSort(). Should be larger
 *  						than one.
 */
func quicksort<T: Comparable>(_ nums: inout Array<T>, cutoff: UInt32 = 64) {
	internalQuicksort(&nums, from: 0, to: nums.count-1, until: cutoff)
}

/**
 *  Implements recursive quicksort, can operate on only part of an array.
 *  - parameter nums:		The array we want to sort
 *  - parameter lowerBound:	The lowest index of an element in the region to be sorted in this iteration
 *  - parameter upperBound:	Same, just the highest index
 */
private func internalQuicksort<T: Comparable>(_ nums: inout Array<T>, from lowerBound: Int, to upperBound: Int, until cutoff: UInt32) {
	if upperBound-lowerBound < cutoff {
		partialInsertionSort(&nums, from: lowerBound, to: upperBound)
		return
	}

	// Select pivot randomly
	var pivot = randInt(upperBound-lowerBound)+lowerBound

	// Swap pivot to the end of the array
	swap(&nums, pivot, upperBound)
	pivot = upperBound

	// Partition the array
	var high = pivot-1
	var low = lowerBound
	while low < high {
		while nums[low] < nums[pivot] {
			low += 1
		}
		while nums[high] >= nums[pivot] {
			high += 1
		}
		if low < high {
			swap(&nums, low, high)
		}
	}
	swap(&nums, low, pivot)

	// Recursive calls
	internalQuicksort(&nums, from: lowerBound, to: low-1, until: cutoff)
	internalQuicksort(&nums, from: low+1, to: upperBound, until: cutoff)
}

/**
 *  An in-place variant of insertion sort, which only sorts the specified part of the array
 *  (including the two boundary elements).
 *  - parameter nums:	The array you want sorted - as inout parameter it will be modified
 *							and in sorted order after the call.
 *  - parameter from:	The index of the first element you want sorted
 *  - parameter to:		The index of the last element you want sorted
 */
func partialInsertionSort<T: Comparable>(_ nums: inout Array<T>, from: Int, to: Int) {
	for i in from+1...to {
		var j = i
		while(j>from && nums[j-1]>nums[j]) {
			let tmp = nums[j-1]
			nums[j-1] = nums[j]
			nums[j] = tmp
			j -= 1
		}
	}
}