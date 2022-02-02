#!/usr/bin/env bash

# build image if missing
if [[ "$(docker image ls -q ipxe_builder 2> /dev/null)" == "" ]]; then
  docker build -t ipxe_builder .
fi

# create ipxe volume if missing
[[ ! -d ipxe ]] && mkdir ipxe

# run the builder with the supplied scripts
# volumes:
# build.sh   -- build script
# embed.ipxe -- embedded ipxe script
# ipxe       -- ipxe git repo
# artifacts  -- output directory
docker run --rm \
  -v $(pwd)/scripts/build.sh:/build.sh \
  -v $(pwd)/scripts/embed.ipxe:/embed.ipxe \
  -v $(pwd)/ipxe:/ipxe \
  -v $(pwd)/artifacts:/artifacts \
  ipxe_builder
