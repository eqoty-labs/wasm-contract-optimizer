# wasm-contract-optimizer

A dockerfile to optimize rust wasm builds targeting wasm32-unknown-unknown

### Build and publish command:
```
docker buildx build --platform linux/amd64,linux/arm64 -t mr7uca/wasm-contract-optimizer:{version} -f ./wasm-contract-optimizer.Dockerfile --push .
```


Dockerhub link: 
[wasm-contract-optimizer](https://hub.docker.com/repository/docker/mr7uca/wasm-contract-optimizer/general)
