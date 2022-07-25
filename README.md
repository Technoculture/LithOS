# yocto-microfabricator envrionment setup

```sh
mkdir repo 
cd repo
repo init -u https://github.com/TechnocultureResearch/yocto-microfabricator -b kirkstone -m kirkstone.xml
repo sync -j16
```

## yocto-microfabricator compilation setup
`mkdir rpi`

## Execute the below command for envrionment setup
`source poky-kirkstone/oe-init-build-env ./rpi/build`

- copy the conf files as below
```sh
cp -rp ../../poky-kirkstone/meta-microfabricator/custom/local.conf.sample conf/local.conf
cp -rp ../../poky-kirkstone/meta-microfabricator/custom/bblayers.conf.sample conf/bblayers.conf
```

# Apply patches
- update the following files
   - for auto login and psplash modification:
      ```
      cd ${WORKDIR}   (WORKDIR is poky-kirkstone directory)
      git apply 0001-psplash-modification-for-custom-image.patch
      ```

   - for eglfs and splash screen and cmdline modification:
      ```
      cd ${WORKDIR}/meta-raspberrypi (WORKDIR is poky-kirkstone directory)
      git apply 0001-Added-fkms-dtb-file-and-updated-psplash-custom-image.patch
      ```

# bitbake command for compilation
```sh
bitbake microfabricator-image
```

# installing image in SDCARD

path to the image file as below:
`cd tmp/deploy/images/raspberrypi4`

flash the image in sdcard as below:
`sudo dd if=./microfabricator-image-raspberrypi4.rpi-sdimg of=/dev/sdX` X-will be your file system (ex: sda,sdb,etc..)

