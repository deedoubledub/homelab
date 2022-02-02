FROM alpine:3

RUN apk add \
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

ENTRYPOINT ["/build.sh"]
