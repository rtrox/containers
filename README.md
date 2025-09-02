<!---
NOTE: AUTO-GENERATED FILE
to edit this file, instead edit its template at: ./github/scripts/templates/README.md.j2
-->
<div align="center">


## Containers

_A Collection of Container Images Optimized for Kubernetes_

</div>

<div align="center">

![GitHub Repo stars](https://img.shields.io/github/stars/rtrox/containers?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/rtrox/containers?style=for-the-badge)
![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/rtrox/containers/release-scheduled.yaml?style=for-the-badge&label=Scheduled%20Release)

</div>

---

## About

This repo contains a collection of containers which are optimized for use in kubernetes, and updated automatically to keep up with upstream versions. Using an image effectively in Kubernetes requires a few ingredients:

- The filesystem must be able to be immutable
- The container must not run as root
- The container shouldn't require any manual interaction
- The container should ideally be configurable via environmental variables

---

## Available Tags

Each Image will be built with the standard `latest` rolling tag, along with tags specific to it's version. For Semantically Versioned containers (e.g. `v1.2.3`), `major`, `major.minor`, and `major.minor.patch` tags will be generated, for example, ![1](https://img.shields.io/badge/1-blue?style=flat-square) ![1.2](https://img.shields.io/badge/1.2-blue?style=flat-square) and ![1.2.3](https://img.shields.io/badge/1.2.3-blue?style=flat-square). Available Images Below.

### Application Images
Application Images are all built from the customer base images below, and will leverage a `/data` and a `/config` volume where these are necessary, and follow the guidelines above for use in Kubernetes.

Container | Channel | Image | Latest Tags
--- | --- | --- | ---
[avahi](https://github.com/rtrox/containers/pkgs/container/avahi) | public | ghcr.io/rtrox/avahi |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.8-r19](https://img.shields.io/badge/0.8--r19-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[dnsmasq](https://github.com/rtrox/containers/pkgs/container/dnsmasq) | public | ghcr.io/rtrox/dnsmasq |![2](https://img.shields.io/badge/2-blue?style=flat-square) ![2.90-r3](https://img.shields.io/badge/2.90--r3-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[keepalived](https://github.com/rtrox/containers/pkgs/container/keepalived) | public | ghcr.io/rtrox/keepalived |![2](https://img.shields.io/badge/2-blue?style=flat-square) ![2.3](https://img.shields.io/badge/2.3-blue?style=flat-square) ![2.3.1-r0](https://img.shields.io/badge/2.3.1--r0-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[necesse-server](https://github.com/rtrox/containers/pkgs/container/necesse-server) | stable | ghcr.io/rtrox/necesse-server |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.24](https://img.shields.io/badge/0.24-blue?style=flat-square) ![0.24.0](https://img.shields.io/badge/0.24.0-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[pdsadmin](https://github.com/rtrox/containers/pkgs/container/pdsadmin) | public | ghcr.io/rtrox/pdsadmin |![latest](https://img.shields.io/badge/latest-green?style=flat-square) ![v0](https://img.shields.io/badge/v0-blue?style=flat-square) ![v0.4](https://img.shields.io/badge/v0.4-blue?style=flat-square) ![v0.4.169](https://img.shields.io/badge/v0.4.169-blue?style=flat-square)
[starbound-server](https://github.com/rtrox/containers/pkgs/container/starbound-server) | public | ghcr.io/rtrox/starbound-server |![16302742-1731930731](https://img.shields.io/badge/16302742--1731930731-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[vikunja-api](https://github.com/rtrox/containers/pkgs/container/vikunja-api) | stable | ghcr.io/rtrox/vikunja-api |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.22](https://img.shields.io/badge/0.22-blue?style=flat-square) ![0.22.1](https://img.shields.io/badge/0.22.1-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[vikunja-frontend](https://github.com/rtrox/containers/pkgs/container/vikunja-frontend) | stable | ghcr.io/rtrox/vikunja-frontend |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.22](https://img.shields.io/badge/0.22-blue?style=flat-square) ![0.22.1](https://img.shields.io/badge/0.22.1-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)


### Base Images
All Base Images are configured with a non-root user (`rtrox:rtrox`), and exposed `/data` and `/config` volumes, and use `tini` as an entrypoint to ensure proper signal handling.

Container | Channel | Image | Latest Tags
--- | --- | --- | ---
[alpine](https://github.com/rtrox/containers/pkgs/container/alpine) | 3.18 | ghcr.io/rtrox/alpine |![3](https://img.shields.io/badge/3-blue?style=flat-square) ![3.18](https://img.shields.io/badge/3.18-blue?style=flat-square) ![3.18.9](https://img.shields.io/badge/3.18.9-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[steamcmd](https://github.com/rtrox/containers/pkgs/container/steamcmd) | stable | ghcr.io/rtrox/steamcmd |![0-20180105-4](https://img.shields.io/badge/0--20180105--4-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[ubuntu](https://github.com/rtrox/containers/pkgs/container/ubuntu) | jammy | ghcr.io/rtrox/ubuntu |![jammy-20250819](https://img.shields.io/badge/jammy--20250819-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
