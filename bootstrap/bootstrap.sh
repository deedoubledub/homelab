#!/usr/bin/env bash

# build ipxe images
pushd ipxe_builder
./generate.sh
popd

# setup the server
pushd netboot
./setup.sh
popd
