// Created 2017-11-03 by LimeThaw

import XCTest

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

func swap<T>(_ arr: inout Array<T>, _ ind1: Int, _ ind2: Int) {
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

func quicksort<T: Comparable>(_ nums: inout Array<T>, cutoff: UInt32 = 64) {
	if nums.count <= cutoff {
		inplaceInsertionSort(&nums);
		return
	}

	// Select pivot randomly
	var pivot = randInt(nums.count)

	// Swap pivot to the end of the array
	swap(&nums, pivot, nums.count-1)
	pivot = nums.count-1

	// Partition the array
	var high = nums.count-2
	var low = 0
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

	var lower = Array(nums[0...low-1])
	var upper = Array(nums[low+1...nums.count-1])

	// Recursive quicksort calls
	quicksort(&lower)
	quicksort(&upper)

	nums = lower+[nums[low]]+upper
}