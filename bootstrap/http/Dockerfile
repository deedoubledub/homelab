FROM nginx:latest
# get talos boot image
ARG TALOS_VERSION
ADD https://github.com/talos-systems/talos/releases/download/${TALOS_VERSION}/vmlinuz-amd64 /usr/share/nginx/html/talos/vmlinuz-amd64
ADD https://github.com/talos-systems/talos/releases/download/${TALOS_VERSION}/initramfs-amd64.xz /usr/share/nginx/html/talos/initramfs-amd64.xz
RUN chmod 644 /usr/share/nginx/html/talos/*
