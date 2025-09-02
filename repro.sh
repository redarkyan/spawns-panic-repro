#!/bin/bash
echo "--- Running DEBUG build ---"
cargo build
cp target/debug/libtest_ffi.a ./
clang main.c -L$(pwd) -ltest_ffi -lm
./a.out
echo ""
echo "--- Running RELEASE build -"
cargo build --release
cp target/release/libtest_ffi.a ./
clang main.c -L$(pwd) -ltest_ffi -lm
./a.out
