docker build docker -t kernel_new
docker run --rm -it -v "$(pwd)":/root/env kernel_new