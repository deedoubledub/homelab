# Bootstrap

```
$ # Copy talos controlplane.yaml into data/http
$ cp env.dist .env
$ # Configure http server path and talos version in .env
$ # Configure http port in compose.yaml
$ docker compose up -d
```

## Overview

The infrastructure required to bootstrap the cluster.

3 x Lenovo ThinkCentre M710q nodes :arrow_right: [Talos](https://www.talos.dev)
cluster :arrow_right: [Kubernetes](https://kubernetes.io) cluster.

- pfSense DHCP configuration for PXE booting
- docker compose stack for building iPXE and serving `tftp` and `http`

## pfSense Configuration

Services :arrow_right: DHCP Server

### TFTP

TFTP Server: IP address of the TFTP server

### Network Booting

Enable: :ballot_box_with_check:\
Next Server: IP address of the TFTP server\
Default BIOS file name: `ipxe.kpxe`\
UEFI 32 bit file name: `ipxe.efi`\
UEFI 64 bit file name: `ipxe.efi`

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

This docker image builds iPXE images for network booting with `tftp/embed.ipxe`
embedded. The boot images are then copied into a tftp server.

- set `HTTP_SCHEME`, `HTTP_SERVER`, and `HTTP_PORT` in `.env`

## HTTP Image

This docker image builds an nginx http server with the Talos kernel and initrd
of the specified version. It serves the iPXE boot menu, Talos boot resources,
and the Talos configuration.

- set the Talos version with `TALOS_VERSION` in `.env`
- set `HTTP_SCHEME`, `HTTP_SERVER`, and `HTTP_PORT` in `.env`
- add `data/http/controlplane.yaml` for Talos configuration
- set the http port in `compose.yaml`

## Cluster Init

1. `$ talosctl bootstrap -n 10.0.0.81`
2. `$ talosctl kubeconfig`
