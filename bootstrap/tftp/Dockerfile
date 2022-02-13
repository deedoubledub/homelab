# builder
FROM alpine:3 AS ipxe
# copy in the custom embedded ipxe script
COPY embed.ipxe /
# configure embedded ipxe script
ARG HTTP_SCHEME
ARG HTTP_SERVER
ARG HTTP_PORT
RUN sed -i "s/SCHEME/$HTTP_SCHEME/; s/SERVER/$HTTP_SERVER/; s/PORT/$HTTP_PORT/" /embed.ipxe
# install build dependencies
RUN apk --no-cache add \
  bash \
  binutils \
  cdrkit \
  gcc \
  git \
  make \
  mtools \
  musl-dev \
  perl \
  sed \
  syslinux \
  xz-dev
# clone the ipxe git repo
RUN git clone https://github.com/ipxe/ipxe.git /ipxe
# enable HTTPS
RUN sed -Ei "s/^#undef([ \t]*DOWNLOAD_PROTO_HTTPS[ \t]*)/#define\1/" /ipxe/src/config/general.h
WORKDIR /ipxe/src
# build efi
RUN make EMBED=/embed.ipxe \
  bin-x86_64-efi/ipxe.efi \
  bin-x86_64-efi/snp.efi \
  bin-x86_64-efi/snponly.efi
# build bios
RUN make EMBED=/embed.ipxe \
  bin/ipxe.dsk \
  bin/ipxe.pdsk \
  bin/ipxe.lkrn \
  bin/ipxe.kpxe \
  bin/undionly.kpxe
# collect artifacts for easy copy
RUN mkdir /artifacts && \
  cp /ipxe/src/bin-x86_64-efi/ipxe.efi /artifacts && \
  cp /ipxe/src/bin-x86_64-efi/snp.efi /artifacts && \
  cp /ipxe/src/bin-x86_64-efi/snponly.efi /artifacts && \
  cp /ipxe/src/bin/ipxe.dsk /artifacts && \
  cp /ipxe/src/bin/ipxe.pdsk /artifacts && \
  cp /ipxe/src/bin/ipxe.lkrn /artifacts && \
  cp /ipxe/src/bin/ipxe.kpxe /artifacts && \
  cp /ipxe/src/bin/undionly.kpxe /artifacts

# image
FROM alpine:3
# install tftp server
RUN apk --no-cache add tftp-hpa
# copy in artifacts
COPY --from=ipxe /artifacts/* /var/lib/tftpboot/
EXPOSE 69/udp
CMD [ "in.tftpd", "--foreground", "--secure", "/var/lib/tftpboot" ]
