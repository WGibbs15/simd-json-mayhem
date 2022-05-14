FROM rust as builder

ADD . /simd-json
WORKDIR /simd-json/fuzz

RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

RUN RUSTFLAGS="-C target-cpu=native" cargo fuzz build real

FROM ubuntu:20.04

COPY --from=builder /simd-json/fuzz/target/x86_64-unknown-linux-gnu/release/real /
