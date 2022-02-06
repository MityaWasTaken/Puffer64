docker build buildenv -t buildenv
docker run --rm -it -v "$(pwd)":/root/env buildenv