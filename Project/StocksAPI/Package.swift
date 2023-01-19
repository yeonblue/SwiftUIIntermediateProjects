// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StocksAPI",
    platforms: [.iOS(.v15), .macOS(.v11), .tvOS(.v15), .watchOS(.v8)], // 지원 범위 설정
    products: [
        .library(
            name: "StocksAPI",
            targets: ["StocksAPI"]),
        .executable(name: "StocksAPIExec", targets: ["StocksAPIExec"]) // 실행 지점 설정
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "StocksAPI",
            dependencies: []),
        .executableTarget(name: "StocksAPIExec", dependencies: ["StocksAPI"]),
        .testTarget(
            name: "StocksAPITests",
            dependencies: ["StocksAPI"]),
    ]
)
