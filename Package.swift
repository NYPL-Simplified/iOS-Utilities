// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NYPLUtilities",
    platforms: [.iOS(.v10), .macOS(.v10_12)],
    products: [
        .library(
            name: "NYPLUtilities",
            targets: ["NYPLUtilities"]),
    ],
    targets: [
        .target(
            name: "NYPLUtilities",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "NYPLUtilitiesTests",
            dependencies: ["NYPLUtilities"],
            path: "Tests"
        ),
    ]
)
