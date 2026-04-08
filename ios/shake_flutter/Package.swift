// swift-tools-version: 5.9
import PackageDescription
import Foundation

let package = Package(
    name: "shake_flutter",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "shake_flutter", targets: ["shake_flutter"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../Flutter"),
        .package(url: ProcessInfo.processInfo.environment["IOS_SHAKE_SPM_URL"], upToNextMinor: "17.2.0-rc.0"),
    ],
    targets: [
        .target(
            name: "shake_flutter",
            dependencies: [
                .product(name: "Flutter", package: "FlutterFramework"),
                .product(name: "Shake", package: ProcessInfo.processInfo.environment["IOS_SHAKE_SPM_PACKAGE_ID"]),
            ],
            cSettings: [
                .headerSearchPath("include/shake_flutter")
            ]
        )
    ]
)