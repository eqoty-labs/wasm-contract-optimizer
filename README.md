# wasm-contract-optimizer

A dockerfile to optimize rust wasm builds targeting wasm32-unknown-unknown

### Build and publish command:
```
docker buildx build --platform linux/amd64,linux/arm64 -t mr7uca/secret-contract-optimizer:{version} -f ./secret-contract-optimizer.Dockerfile --push .
```