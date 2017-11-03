# emu

This little project is meant as a fun little collaborative library for data structures and
algorithms. Whoever feels like it is welcome to contribute some code, and anyone can use
it in their programs.

## Structure

For each element, there should be a source file and a test file. The source file, describing
functionality, belongs into Sources/emu, and the test file, describing test cases for
validating functionality, belongs into Tests/emuTests. You also need to write an entry for
every test file into Tests/LinuxMain.swift.

## Usage

The code is written for Swift 4. To build and test simply navigate to the root directory
and run ´swift build && swift test´.