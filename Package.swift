// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "TabBar",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "TabBar",
            targets: ["TabBar"]
        )
    ],
    targets: [
        .target(name: "TabBar")
    ]
)
