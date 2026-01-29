#!/bin/bash

LINKER_FLAGS="-Wl,--allow-multiple-definition"

echo "--- Running DEBUG build ---"
cargo build --manifest-path=ffi_v1/Cargo.toml
cargo build --manifest-path=ffi_v2/Cargo.toml
cp target/debug/libffi_v1.a ./
cp target/debug/libffi_v2.a ./
clang main.c -L$(pwd) -lffi_v1 -lffi_v2 -lm $LINKER_FLAGS
./a.out
echo ""
echo "--- Running RELEASE build ---"
cargo build --release --manifest-path=ffi_v1/Cargo.toml
cargo build --release --manifest-path=ffi_v2/Cargo.toml
cp target/release/libffi_v1.a ./
cp target/release/libffi_v2.a ./
clang main.c -L$(pwd) -lffi_v1 -lffi_v2 -lm $LINKER_FLAGS
./a.out
