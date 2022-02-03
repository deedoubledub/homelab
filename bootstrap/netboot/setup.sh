#!/usr/bin/env bash

# copy boot images from ipxe_builder
cp ../ipxe_builder/artifacts/ipxe.efi config/tftp
cp ../ipxe_builder/artifacts/snp.efi config/tftp
cp ../ipxe_builder/artifacts/snponly.efi config/tftp
cp ../ipxe_builder/artifacts/ipxe.dsk config/tftp
cp ../ipxe_builder/artifacts/ipxe.kpxe config/tftp
cp ../ipxe_builder/artifacts/ipxe.lkrn config/tftp
cp ../ipxe_builder/artifacts/ipxe.pdsk config/tftp
cp ../ipxe_builder/artifacts/undionly.kpxe config/tftp

# get talos kernel
version='v0.14.1'
curl -L https://github.com/talos-systems/talos/releases/download/${version}/vmlinuz-amd64 \
     -o config/http/talos/vmlinuz-amd64
curl -L https://github.com/talos-systems/talos/releases/download/${version}/initramfs-amd64.xz \
     -o config/http/talos/initramfs-amd64.xz

# start the stack
docker compose up -d --force-recreate
