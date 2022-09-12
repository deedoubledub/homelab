# Bootstrap

```
$ # Copy talos controlplane.yaml into config/http
$ # Configure talos version in compose.yaml
$ docker compose up -d
```

## Overview

The infrastructure required to bootstrap the cluster.

3 x Lenovo ThinkCentre M710q nodes :arrow_right: [Talos](https://www.talos.dev)
cluster :arrow_right: [Kubernetes](https://kubernetes.io) cluster.

- pfSense DHCP configuration for PXE booting
- docker compose stack for `tftp` and `http`

## pfSense Configuration

Services :arrow_right: DHCP Server

### TFTP

TFTP Server: IP address of the TFTP server

### Network Booting

Enable: :ballot_box_with_check:\
Next Server: IP address of the TFTP server\
UEFI 64 bit file name: `grubx64.efi`

Add DHCP Static Mappings for each node:

| MAC address       | IP address | Hostname | Description |
| ----------------- | ---------- | -------- | ----------- |
| 6c:4b:90:6b:b8:ab | 10.0.0.81  | k1       | k8s node1   |
| 6c:4b:90:a8:ed:6e | 10.0.0.82  | k2       | k8s node2   |
| 6c:4b:90:a8:ee:bd | 10.0.0.83  | k3       | k8s node3   |

### DNS

Add DNS Host Override for the Kubernetes VIP

Services :arrow_right: DNS Resolver

| Host | Domain      | IP address | Description     |
| ---- | ----------- | ---------- | --------------- |
| kube | example.com | 10.0.0.80  | k8s control VIP |

## TFTP Image

This docker image hosts a tftp server with GRUB and Talos boot resources.

- set the Talos version with `TALOS_VERSION` in `compose.yaml`
- set the sha256 checksums of the downloaded resources in `compose.yaml`

## HTTP Image

This docker image hosts an nginx http server with the Talos configuration.

- add `config/http/controlplane.yaml` for Talos configuration

## GParted

For GParted Live support extract the GParted Live zip archive and then:
- copy `live/initrd.img` and `live/vmlinuz` into `config/tftp/gparted`.
- copy `live/filesystem.squashfs` into `config/http/gparted`

## Cluster Init

1. `$ talosctl bootstrap -n 10.0.0.81`
2. `$ talosctl kubeconfig`
