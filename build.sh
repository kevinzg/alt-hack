#!/usr/bin/env bash

mkdir -p build

docker build -t hackslash .

docker run --rm -it \
    -v $(pwd)/build:/root/Hack/build \
    -v $(pwd)/patch-hack.sh:/root/alt-hack/patch-hack.sh \
    hackslash \
    bash -c './patch-hack.sh && cd $HACK_PATH && ./build-ttf.sh'

echo "Done"
