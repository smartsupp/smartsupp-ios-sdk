// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Smartsupp",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Smartsupp",
            targets: ["Smartsupp"]),
    ],
    targets: [
        .binaryTarget(
            name: "Smartsupp",
            path: "Framework/Smartsupp.xcframework"
        ),
    ]
)
