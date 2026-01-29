#!/bin/bash

# When multiple static libraries with LTO enabled share dependencies,
# duplicate symbols cause linker errors. The solution is to either:
# 1. Disable LTO in the workspace (allows linking without special flags)
# 2. Build libraries without LTO (can be linked together)
# 3. Use special linker flags to suppress errors
#
# We use approach #3: Keep LTO enabled (lto = "fat" in Cargo.toml) for
# maximum optimization. Try multiple linker flag combinations:

# Option 1: Allow common symbols to use dylib resolution
LINKER_FLAGS="-Wl,-commons,use_dylibs"

# Option 2: Suppress all warnings (if option 1 doesn't work)
# LINKER_FLAGS="-Wl,-w"

# Option 3: Force flat namespace (deprecated, last resort)
# LINKER_FLAGS="-Wl,-flat_namespace -Wl,-undefined,suppress"

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
