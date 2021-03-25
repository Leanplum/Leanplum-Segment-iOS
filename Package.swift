// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LeanplumSegment",
    platforms: [.iOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LeanplumSegment",
            targets: ["LeanplumSegment"])
    ],
    dependencies: [
        .package(
            name: "Leanplum",
            url: "https://github.com/Leanplum/Leanplum-iOS-SDK.git",
            .upToNextMajor(from: "3.1.1")
        ),
        .package(
            name: "Segment",
            url: "https://github.com/segmentio/analytics-ios.git",
            .upToNextMajor(from: "4.1.3")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LeanplumSegment",
            dependencies: [
                .product(name: "Segment", package: "Segment"),
                .product(name: "Leanplum", package: "Leanplum")
            ],
            path: "Pod",
            cSettings: [
                .headerSearchPath("Classes")
            ]
        )
    ]
)
