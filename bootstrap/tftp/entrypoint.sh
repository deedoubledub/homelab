#!/bin/sh -l

# setup directory structure
mkdir -p /var/lib/tftpboot/grub /var/lib/tftpboot/talos

# download resources
if ! echo "$GRUBCONF_CHECKSUM  /var/lib/tftpboot/grub/grub.cfg" | sha256sum -c -; then
  echo "grub.cfg checksum mismatch -- downloading"
  curl -sL https://raw.githubusercontent.com/deedoubledub/homelab/main/bootstrap/tftp/grub.cfg -o /var/lib/tftpboot/grub/grub.cfg

  # verify checksum
  echo "$GRUBCONF_CHECKSUM  /var/lib/tftpboot/grub/grub.cfg" | sha256sum -c - || { echo "grub.cfg checksum mismatch -- download failure"; exit 1; }
fi

if ! echo "$GRUB_CHECKSUM  /var/lib/tftpboot/grubx64.efi" | sha256sum -c -; then
  echo "grubx64.efi checksum mismatch -- downloading"
  curl -sL http://ftp.us.debian.org/debian/pool/main/g/grub-efi-amd64-signed/grub-efi-amd64-signed_1+2.06+3~deb11u1_amd64.deb -o /tmp/grub-efi-signed.deb

  # extract efi image
  echo "extracting grubx64.efi"
  mkdir /tmp/grub
  ar x /tmp/grub-efi-signed.deb --output=/tmp/grub
  tar xf /tmp/grub/data.tar.xz -C /tmp/grub
  mv /tmp/grub/usr/lib/grub/x86_64-efi-signed/grubnetx64.efi.signed /var/lib/tftpboot/grubx64.efi
  rm -rf /tmp/grub

  # verify checksum
  echo "$GRUB_CHECKSUM  /var/lib/tftpboot/grubx64.efi" | sha256sum -c - || { echo "grubx64.efi checksum mismatch -- download failure"; exit 1; }
fi

if ! echo "$TALOS_VMLINUZ_CHECKSUM  /var/lib/tftpboot/talos/vmlinuz-amd64" | sha256sum -c -; then
  echo "talos vmlinuz-amd64 checksum mismatch -- downloading"
  curl -sL https://github.com/siderolabs/talos/releases/download/${TALOS_VERSION}/vmlinuz-amd64 -o /var/lib/tftpboot/talos/vmlinuz-amd64

  # verify checksum
  echo "$TALOS_VMLINUZ_CHECKSUM  /var/lib/tftpboot/talos/vmlinuz-amd64" | sha256sum -c - || { echo "talos vmlinuz-amd64 checksum mismatch -- download failure"; exit 1; }
fi

if ! echo "$TALOS_INITRAMFS_CHECKSUM  /var/lib/tftpboot/talos/initramfs-amd64.xz" | sha256sum -c -; then
  echo "talos initramfs-amd64.xz checksum mismatch -- downloading"
  curl -sL https://github.com/siderolabs/talos/releases/download/${TALOS_VERSION}/initramfs-amd64.xz -o /var/lib/tftpboot/talos/initramfs-amd64.xz

  # verify checksum
  echo "$TALOS_INITRAMFS_CHECKSUM  /var/lib/tftpboot/talos/initramfs-amd64.xz" | sha256sum -c - || { echo "talos initramfs-amd64.xz checksum mismatch -- download failure"; exit 1; }
fi

# start tftp server
in.tftpd --foreground --secure /var/lib/tftpboot
