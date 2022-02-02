#!/usr/bin/env bash

# clone the ipxe repo if not volume mounted
[[ ! -d /ipxe/.git ]] && git clone https://github.com/ipxe/ipxe.git /ipxe

# update git repo
cd /ipxe
git pull

# Enable HTTPS
sed -Ei "s/^#undef([ \t]*DOWNLOAD_PROTO_HTTPS[ \t]*)/#define\1/" /ipxe/src/config/general.h

# cleanup
cd /ipxe/src
make clean

# build efi
make EMBED=/embed.ipxe \
     bin-x86_64-efi/ipxe.efi \
     bin-x86_64-efi/snp.efi \
     bin-x86_64-efi/snponly.efi \

# build bios
make EMBED=/embed.ipxe \
     bin/ipxe.dsk \
     bin/ipxe.pdsk \
     bin/ipxe.lkrn \
     bin/ipxe.kpxe \
     bin/undionly.kpxe

# copy to artifacts volume
cp /ipxe/src/bin-x86_64-efi/ipxe.efi /artifacts
cp /ipxe/src/bin-x86_64-efi/snp.efi /artifacts
cp /ipxe/src/bin-x86_64-efi/snponly.efi /artifacts
cp /ipxe/src/bin/ipxe.dsk /artifacts
cp /ipxe/src/bin/ipxe.pdsk /artifacts
cp /ipxe/src/bin/ipxe.lkrn /artifacts
cp /ipxe/src/bin/ipxe.kpxe /artifacts
cp /ipxe/src/bin/undionly.kpxe /artifacts
