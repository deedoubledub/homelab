FROM nginx:latest
# get talos boot image
ARG TALOS_VERSION
ADD https://github.com/talos-systems/talos/releases/download/${TALOS_VERSION}/vmlinuz-amd64 /usr/share/nginx/html/talos/vmlinuz-amd64
ADD https://github.com/talos-systems/talos/releases/download/${TALOS_VERSION}/initramfs-amd64.xz /usr/share/nginx/html/talos/initramfs-amd64.xz
RUN chmod 644 /usr/share/nginx/html/talos/*
# configure boot menu
ARG HTTP_SCHEME
ARG HTTP_SERVER
ARG HTTP_PORT
COPY boot.ipxe /usr/share/nginx/html/boot.ipxe
RUN sed -i "s/SCHEME/$HTTP_SCHEME/; s/SERVER/$HTTP_SERVER/; s/PORT/$HTTP_PORT/" /usr/share/nginx/html/boot.ipxe
