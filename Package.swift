// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "SwiftGBA",
  products: [
   .executable(name: "SwiftGBA", targets: ["SwiftGBA"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "Syscalls"),
    .executableTarget(
      name: "SwiftGBA",
      dependencies: [
        "Syscalls"
      ],
      exclude: ["Bridging-Header.h"],
      swiftSettings: [
        .unsafeFlags([
          "-Ounchecked",
          "-Xfrontend", "-function-sections",
          "-Xfrontend", "-experimental-hermetic-seal-at-link",
          "-import-objc-header", "Sources/SwiftGBA/Bridging-Header.h",
        ]),
        .enableExperimentalFeature("Embedded"),
        .enableExperimentalFeature("Volatile")
      ]
    )
  ])
