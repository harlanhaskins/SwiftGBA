// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "SwiftGBA",
  platforms: [
    .macOS(.v14),
  ],
  products: [
      .executable(name: "SwiftGBA", targets: ["SwiftGBA"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Syscalls",
      cSettings: [
        .unsafeFlags(["-I", "Tools/lib/clang-runtimes/arm-none-eabi/armv4t/include"])
      ]),
    .executableTarget(
      name: "SwiftGBA",
      dependencies: [
        "Syscalls"
      ],
      exclude: ["Bridging-Header.h"],
      cSettings: [
        .unsafeFlags([
          "--sysroot", "lib/clang-runtimes/arm-none-eabi/armv4t"
        ]),
        .headerSearchPath("Tools/lib/clang-runtimes/arm-none-eabi/armv4t/include"),
        .define("_LIBCPP_AVAILABILITY_HAS_NO_VERBOSE_ABORT"),
      ],
      swiftSettings: [
        .unsafeFlags([
          "-Ounchecked",
          "-I", "Tools/lib/clang-runtimes/arm-none-eabi/armv4t/include",
          "-target", "armv4t-none-none-eabi",
          "-Xfrontend", "-function-sections",
          "-Xfrontend", "-experimental-hermetic-seal-at-link",
          "-import-objc-header", "Sources/SwiftGBA/Bridging-Header.h"
        ]),
        .enableExperimentalFeature("Embedded"),
        .enableExperimentalFeature("Volatile")
      ],
      linkerSettings: [
        .linkedLibrary("tonc"),
        .linkedLibrary("crt0-gba"),
        .unsafeFlags([
          "-use-ld=lld",
          "-L", "Tools/lib/clang-runtimes/arm-none-eabi/armv4t/lib",
          "-Xlinker", "-T",
          "-Xlinker", "Tools/lib/clang-runtimes/arm-none-eabi/armv4t/lib/gba_cart.ld",
          "-Xlinker", "-z", "-Xlinker", "norelro",
        ])
      ])
  ])
