// Created 2017-11-02 by LimeThaw

/**
 *  Insertion sort is a simple sorting algorithm with runtime O(n^2), that works by inserting
 *  the elements one by one into their proper place in the sorted part of the array.
 *  @param	nums	The array you want sorted
 */
func insertionSort<T: Comparable>(_ nums: Array<T>) -> Array<T> {

	// Create a local copy, since parameters are constant.
	var locNums = nums;

	// Iterate through all entries to insert them
	for i in 1...locNums.count-1 {

		// Swap them down until they are in their place
		var j = i
		// > istead of >= gives us stability
		while(j>0 && locNums[j-1]>locNums[j]) {

			// Swap down
			let tmp = locNums[j-1]
			locNums[j-1] = locNums[j]
			locNums[j] = tmp

			// Keep swapping?
			j -= 1
		}
	}
	return locNums
}

/**
 *  An in-place variant of insertion sort. Performs the same actions as the other one, but
 *  makes use of inout parameters, so it doesn't have to copy the array.
 *  @param	nums	The array you want sorted
 */
func inplaceInsertionSort<T: Comparable>(_ nums: inout Array<T>) {
	for i in 1...nums.count-1 {
		var j = i
		while(j>0 && nums[j-1]>nums[j]) {
			let tmp = nums[j-1]
			nums[j-1] = nums[j]
			nums[j] = tmp
			j -= 1
		}
	}
}