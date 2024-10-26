#!/usr/bin/env sh

set -x
arch=$(uname -m)
platform=$(uname)
if [[ $platform == Darwin ]]; then
  if [[ $arch == arm64 ]]; then
    if [ -d Tools ]; then
      read -p "Tools dir exists, overwrite? [y|N] " overwrite
      if [[ ! $overwrite =~ ^[yY] ]]; then
        echo "Nothing to do"
        exit 0
      fi
      rm -rf Tools
    fi
    mkdir -p Tools
    echo "Downloading tools for macOS..."
    curl -L "https://github.com/stuij/gba-llvm-devkit/releases/download/release-v1/gba-llvm-devkit-1-Darwin-arm64.dmg" -o /tmp/Tools.dmg
    echo "Copying files"
    hdiutil attach /tmp/Tools.dmg
    cp -r "/Volumes/gba-llvm-devkit-1-Darwin-arm64/gba-llvm-devkit-1-Darwin-arm64"/* Tools/.
    pushd 'Tools/lib/clang-runtimes/arm-none-eabi/armv4t/lib/'
    ln -s libclang_rt.builtins.a libclang_rt.builtins-armv4t.a
    popd
  else
    echo "Only Apple Silicon is supported"
    exit -1
  fi
else
  echo "Only macOS is supported."
  exit -1
fi
