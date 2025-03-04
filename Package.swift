// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "SwiftGBA",
  products: [
    .library(name: "SwiftGBA", targets: ["SwiftGBA"]),
    .executable(name: "DVD", targets: ["DVD"]),
    .executable(name: "Game", targets: ["Game"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "Syscalls"),
    .target(
      name: "SwiftGBA",
      dependencies: [
        "Syscalls"
      ]
    ),
    .executableTarget(name: "DVD", dependencies: ["SwiftGBA"]),
    .executableTarget(name: "Game", dependencies: ["SwiftGBA"]),
  ])
