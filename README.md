# My Homelab

The source code for my home server infrastructure.

## Overview

A look at the infrastructure from hardware to cluster to hosting services.

### Hardware

- Netgate SG-2100
- MikroTik CSS610-8G-2S+in
- TinyPilot Voyager
- FJGEAR 4 port HDMI KVM Switch
- 3 x Lenovo ThinkCentre M710q

### [Bootstrap](bootstrap)

Configure the infrastructure to bootstrap the cluster via network booting.

- DHCP -- net boot to TFTP
- TFTP -- net boot via GRUB with Talos kernel
- HTTP -- serve Talos configuration

### [Base](base)

Configure Argo CD to deploy core services.

### Maintenance

#### Talos Upgrade

```
talosctl upgrade --image ghcr.io/siderolabs/installer:vX.Y.Z --wait -n 10.20.30.40
```
