#!/bin/bash
echo "--- Running RELEASE build -"
cargo build --release
clang main.c -L$(pwd)/target/release -ltest_ffi -lm -o target/release/a.out
./target/release/a.out
