// swift-tools-version: 5.9
import PackageDescription
import Foundation

let url: String = ProcessInfo.processInfo.environment["IOS_SHAKE_SPM_URL"]!
let packageName: String = ProcessInfo.processInfo.environment["IOS_SHAKE_SPM_PACKAGE"]!

let shakeDependency: Package.Dependency = url.contains("staging")
    ? .package(url: url, exact: "17.2.4-rc.1637")
    : .package(url: url, .upToNextMinor(from: "17.2.0"))

let package = Package(
    name: "shake_flutter",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "shake-flutter", targets: ["shake_flutter"])
    ],
    dependencies: [
        shakeDependency,
    ],
    targets: [
        .target(
            name: "shake_flutter",
            dependencies: [
                .product(name: "Shake", package: packageName),
            ],
            cSettings: [
                .headerSearchPath("include/shake_flutter")
            ]
        )
    ]
)
