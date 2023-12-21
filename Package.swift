// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AENetworkKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AENetworkKit",
            targets: ["AENetworkKit"]
        )
    ],
    targets: [
        .target(
            name: "AENetworkKit"
        ),
        .testTarget(
            name: "AENetworkKitTests",
            dependencies: ["AENetworkKit"]
        )
    ]
)
