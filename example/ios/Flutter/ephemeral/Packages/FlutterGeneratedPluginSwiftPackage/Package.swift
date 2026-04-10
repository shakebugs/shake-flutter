// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .iOS("15.6")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "url_launcher_ios", path: "../.packages/url_launcher_ios"),
        .package(name: "shake_flutter", path: "../.packages/shake_flutter"),
        .package(name: "path_provider_foundation", path: "../.packages/path_provider_foundation"),
        .package(name: "package_info_plus", path: "../.packages/package_info_plus"),
        .package(name: "flutter_local_notifications", path: "../.packages/flutter_local_notifications"),
        .package(name: "firebase_messaging", path: "../.packages/firebase_messaging"),
        .package(name: "firebase_core", path: "../.packages/firebase_core")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "url-launcher-ios", package: "url_launcher_ios"),
                .product(name: "shake-flutter", package: "shake_flutter"),
                .product(name: "path-provider-foundation", package: "path_provider_foundation"),
                .product(name: "package-info-plus", package: "package_info_plus"),
                .product(name: "flutter-local-notifications", package: "flutter_local_notifications"),
                .product(name: "firebase-messaging", package: "firebase_messaging"),
                .product(name: "firebase-core", package: "firebase_core")
            ]
        )
    ]
)
