# LithOS

[![Build LithOS Image](https://github.com/TechnocultureResearch/LithOS/actions/workflows/buildImage.yml/badge.svg?branch=kirkstone)](https://github.com/TechnocultureResearch/LithOS/actions/workflows/buildImage.yml)

## Pre-requisites

- Docker

### Clone kas

```sh
git clone https://github.com/siemens/kas
```

This repositiry contains the script that we will be using to build images, sdk and access the yocto development environment. The key script we will be using is `kas-container`.

## Build Instructions

### Build Image

This command will build the image.

```sh
$PATH_TO_KAS_DIR/kas-container build kirkstone.yaml
```

### Access development environment shell

```sh
$PATH_TO_KAS_DIR/kas-container shell kirkstone.yaml
```

---

> Refer the [documentation](https://kas.readthedocs.io/en/latest/) for more info.
> This approach comes from [this blog](https://embeddeduse.com/2022/06/24/setting-up-yocto-projects-with-kas/) by [Embedded Use](https://embeddeduse.com).
