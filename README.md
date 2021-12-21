This little project is meant as a fun little collaborative library for data structures and
algorithms. Whoever feels like it is welcome to contribute some code, and anyone can use
it in their programs.

## Structure

The library is partitioned into three submodules. The first one is just called "emu" and contains
basic data sctructures and algorithms. The second is called "functional" and contains code that is
[purely functional](https://en.wikipedia.org/wiki/Purely_functional_programming#Properties_of_purely_functional_program).
The third one is called "threadsafe" and contains - you guessed it - thread safe code.
Additionally, each submodule is divided into two categories: datastructures and algorithms. Their
meaning should be rather self explanatory.

For each element, there should be a source file and a test file. The source file, describing
functionality, belongs into Sources/submodule/category/, and the test file, describing test cases for
validating functionality, belongs into Tests/submoduleTests/category/. You also need to write an entry for
every test file into Tests/LinuxMain.swift.

## Naming

To make the project easier to navigate and appear more uniform, all contributions should adhere
to the same naming conventions. For example, the algorithm Bogo Sort should be implemented in
the function bogoSort() (class for data structures) in the file BogoSort.swift. The
corresponding tests should be in the class bogoSortTests in the file BogoSortTests.swift.
All test functions should have meaningful names and start with "test", like testSortingSortedList.

## Usage

The code is written for Swift 5. To build and test simply navigate to the root directory
and run `swift build && swift test`.
