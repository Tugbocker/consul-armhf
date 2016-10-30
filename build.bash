#!/usr/bin/env bash
DUMB_INIT_TAG=v1.0.0
DUMB_INIT_HASH=a9eadb580c0d234fc4090c1bf3f19f8d87bff76b

# Clear out the working folder and make the initial structure.
rm -rf pkg
mkdir -p pkg/build

# Build dumb-init
git clone -b "$DUMB_INIT_TAG" https://github.com/Yelp/dumb-init.git pkg/build/dumb-init
pushd pkg/build/dumb-init
if $(git show-ref --verify refs/tags/${DUMB_INIT_TAG} | grep --quiet "$DUMB_INIT_HASH") ; then
    echo "Verified dumb-init git repository state"
else
    echo "Could not verify dumb-init git repository state"
    exit 1
fi
make
popd
cp pkg/build/dumb-init/dumb-init context/

