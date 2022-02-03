# Bootstrap

Shortcut: execute `bootstrap.sh` and add Talos configuration

The infrastructure required to bootstrap the cluster.

3 x Lenovo ThinkCentre M710q nodes :arrow_right: [Talos](https://www.talos.dev)
cluster :arrow_right: [Kubernetes](https://kubernetes.io) cluster.

- pfSense DHCP configuration for PXE booting
- docker container for building iPXE
- docker compose configuration for hosting `tftp` and `http` to network boot

## pfSense

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

## ipxe_builder

This docker image generates iPXE images for network booting.

1. edit `scripts/build.sh` to modify the build process
2. edit `scripts/embed.ipxe` to modify the embedded ipxe script / boot process

Execute `generate.sh` to build the image, clone the iPXE git repo, and build
the iPXE images in `artifacts/`.

## netboot

This docker compose stack builds a TFTP server to serve the boot images and an
HTTP server to host the iPXE and Talos resources.

- edit `setup.sh` to configure the version of Talos to fetch
- edit `config/http/boot.ipxe` to modify the boot sequence
- add `config/http/talos/controlplane.yaml` for Talos configuration

Execute `setup.sh` to build the TFTP image, copy the boot images into place,
download the Talos kernel and initrd, and start the compose stack to serve it.
