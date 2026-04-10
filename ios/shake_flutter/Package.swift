// swift-tools-version: 5.9
import PackageDescription
import Foundation

let isStaging: Bool = ProcessInfo.processInfo.environment["IOS_SHAKE_SPM_STAGING"] != nil
let shakeVersion: Package.Dependency.Requirement = isStaging
  ? .exact("17.2.4-rc.1637")
  : .upToNextMinor(from: "17.2.0")

let package = Package(
    name: "shake_flutter",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "shake-flutter", targets: ["shake_flutter"])
    ],
    dependencies: [
        .package(url: ProcessInfo.processInfo.environment["IOS_SHAKE_SPM_URL"], requirement: shakeVersion),
    ],
    targets: [
        .target(
            name: "shake_flutter",
            dependencies: [
                .product(name: "Shake", package: ProcessInfo.processInfo.environment["IOS_SHAKE_SPM_PACKAGE"]),
            ],
            cSettings: [
                .headerSearchPath("include/shake_flutter")
            ]
        )
    ]
)