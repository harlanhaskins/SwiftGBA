# SwiftGBA

This is a proof-of-concept of building Swift for Game Boy Advance, based
on [gba-llvm-devkit](https://github.com/stuij/gba-llvm-devkit). It has two
built-in examples: A rectangle that bounces around the screen, and a rectangle
that can be controlled with the D-Pad.

## Building

You will need a recent Swift 6.1 nightly toolchain installed. I have only
built this on macOS, and I have only ever tried to run the tools on macOS. It
would be great to get this project building for Linux; the GBA LLVM Toolkit
has a Linux build already.

Once you have a recent Swift toolchain installed, you'll need to download the
GBA LLVM DevKit. There's a script to grab the latest build and copy it into
place; just run:

```bash
./retrieve-tools.sh
```

Once that's retrieved, you can run `make` to build with Swift Package Manager.
SwiftPM handles almost all of the build, and there's a small post-processing
step that the Makefile takes care of after.

## Author

Harlan Haskins ([harlan@harlanhaskins.com](mailto:harlan@harlanhaskins.com))
