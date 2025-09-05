#!/bin/bash
echo "--- Running DEBUG build ---"
cargo build
clang main.c -L$(pwd)/target/debug -ltest_ffi -lm -o target/debug/a.out
./target/debug/a.out
