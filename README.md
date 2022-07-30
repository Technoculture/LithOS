# LithOS

## Pre-requisites
- Docker

### Clone kas
```sh
> git clone https://github.com/siemens/kas
```

This repositiry contains the script that we will be using to build images, sdk and access the yocto development environment. The key script we will be using is `kas-container`.

## Build Instructions

### Build Image
```sh
> $PATH_TO_KAS_DIR/kas-container build kirkstone.yaml
```

This command will build the image.

### Access development environment
```sh
> $PATH_TO_KAS_DIR/kas-container shell kirkstone.yaml
```

---

Refer the [documentation](https://kas.readthedocs.io/en/latest/) for more info. 
