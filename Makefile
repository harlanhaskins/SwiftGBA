# Determine file paths
CONFIG := release
SRCROOT := $(shell git rev-parse --show-toplevel)
TOOLSROOT := $(SRCROOT)/Tools
BUILDROOT := $(SRCROOT)/.build/$(CONFIG)
BINARY := $(BUILDROOT)/SwiftGBA
ROM := $(BUILDROOT)/SwiftGBA.gba

# Setup tools and build flags
ARCH := armv4t
TARGET := $(ARCH)-none-none-eabi

TOOLCHAIN := /Library/Developer/Toolchains/swift-latest.xctoolchain
SWIFT_BUILD := $(TOOLCHAIN)/usr/bin/swift-build
CLANG := $(TOOLCHAIN)/usr/bin/clang

.PHONY: build
build: $(ROM)

# Step 1: Build the executable with swift-build.
.PHONY: $(BINARY) # Force it to be re-run every `make`.
$(BINARY):
	$(SWIFT_BUILD) -vv -c $(CONFIG) --triple $(TARGET) --toolset toolset.json

# Step 2: Build the ROM by stripping and copying the binary, then running gbafix.
$(ROM) : $(BINARY)
	$(TOOLSROOT)/bin/llvm-objcopy -O binary $(BINARY) $(ROM)
	$(TOOLSROOT)/bin/gbafix $(ROM)

clean:
	@swift package clean
	@rm -rf .build

