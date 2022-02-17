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

- DHCP -- net boot into iPXE
- TFTP -- load iPXE
- iPXE -- net boot from HTTP
- HTTP -- serve iPXE menus, Talos kernel and initrd, and Talos configuration

### [Base](base)

Configure Argo CD to deploy core services.
