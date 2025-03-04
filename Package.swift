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
    )
  ])
