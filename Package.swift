// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "emu",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "emu",
            targets: ["emu"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "emu",
            dependencies: ["functional", "threadsafe", "Rainbow"]),
        .testTarget(
            name: "emuTests",
            dependencies: ["emu"]),
        .target(name: "functional", dependencies: []),
        .testTarget(name: "functionalTests", dependencies: ["functional"]),
        .target(name: "threadsafe", dependencies: []),
        //.testTarget(name: "threadsafeTests", dependencies: ["threadsafe"])
    ],
    swiftLanguageVersions: [5]
)
