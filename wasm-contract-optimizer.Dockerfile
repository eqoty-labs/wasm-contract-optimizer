# Use the specified Rust image
FROM rust:1.75.0-alpine3.18

# Add the WebAssembly target
RUN rustup target add wasm32-unknown-unknown

# Set up build dependencies
RUN apk add --no-cache build-base cmake git clang

# Clone Binaryen and build it
RUN git clone --branch version_116 --recurse-submodules https://github.com/WebAssembly/binaryen.git && \
    cd binaryen && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Set the working directory
WORKDIR /contract

# Build, optimize, and compress the WebAssembly binaries
# Note: Since Alpine uses ash shell by default, the entrypoint is adjusted to use sh instead of bash.
ENTRYPOINT ["/bin/sh", "-c", "\
    RUSTFLAGS='-C link-arg=-s' cargo build --release --target wasm32-unknown-unknown --locked && \
    (mkdir -p ./optimized-wasm/ && rm -f ./optimized-wasm/* && cp ./target/wasm32-unknown-unknown/release/*.wasm ./optimized-wasm/) && \
    for w in ./optimized-wasm/*.wasm; do \
        wasm-opt -Oz $w -o $w ; \
    done && \
    (cd ./optimized-wasm && gzip -n -9 -f *) \
"]
