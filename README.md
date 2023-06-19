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

Container | Channel | Image | Latest Tags
--- | --- | --- | ---
[necesse-server](https://github.com/rtrox/containers/pkgs/container/necesse-server) | stable | ghcr.io/rtrox/necesse-server |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.21](https://img.shields.io/badge/0.21-blue?style=flat-square) ![0.21.29](https://img.shields.io/badge/0.21.29-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
[alpine](https://github.com/rtrox/containers/pkgs/container/alpine) | 3.18 | ghcr.io/rtrox/alpine |![3](https://img.shields.io/badge/3-blue?style=flat-square) ![3.18](https://img.shields.io/badge/3.18-blue?style=flat-square) ![3.18.2](https://img.shields.io/badge/3.18.2-blue?style=flat-square) ![latest](https://img.shields.io/badge/latest-green?style=flat-square)
