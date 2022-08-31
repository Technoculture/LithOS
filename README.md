# LithOS

[![Build LithOS Image](https://github.com/TechnocultureResearch/LithOS/actions/workflows/buildImage.yml/badge.svg?branch=kirkstone)](https://github.com/TechnocultureResearch/LithOS/actions/workflows/buildImage.yml)

## Pre-requisites

```sh
sudo apt install python3 python3-pip
```
```sh
sudo pip3 install distro jsonschema kconfiglib PyYAML
```
- Docker,Cargo

```sh
sudo apt-get update
```
```sh
 sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
```
```sh
sudo mkdir -p /etc/apt/keyrings
```
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

```sh
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```sh
sudo apt-get update
```
```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

```sh
apt-cache madison docker-ce
```
-Install a specific version  using version string from second column 
`
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io docker-compose-plugin
`
```sh
sudo apt-get install docker-ce= 5:20.10.17~3-0~ubuntu-focal docker-ce-cli= 5:20.10.17~3-0~ubuntu-focal containerd.io docker-compose-plugin
```
-Check if docker installation successfull
```sh
sudo docker run hello-world
```
### Clone kas

```sh
git clone https://github.com/siemens/kas
```

```sh
sudo groupadd docker
```

This repository contains the script that we will be using to build images, sdk and access the yocto development environment. The key script we will be using is `kas-container`.

## Build Instructions

### Build Image

Use this command from LithOS repo to build the image.

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

---

> ⚠️ [`OTA Procedure`](./OTA.md)
