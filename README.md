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

# modify the source files
- update the following files
   - for auto login:
      `gedit ../../poky-kirkstone/meta/recipes-core/systemd/systemd-serialgetty/serial-getty@.service` - line number 34

      `-ExecStart=-/sbin/agetty -8 -L %I @BAUDRATE@ $TERM`
      `+ExecStart=-/sbin/agetty -a root -8 -L %I @BAUDRATE@ $TERM`

   - for eglfs and touch:
      `gedit ../../poky-kirkstone/meta-raspberrypi/recipes-bsp/bootfiles/rpi-config_git.bb` - line number 27
      `VC4GRAPHICS="${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "1", "0", d)}"`
      `-VC4DTBO ?= "vc4-kms-v3d"`
      `+VC4DTBO ?= "vc4-fkms-v3d"`

   - `gedit ../../poky-kirkstone/meta-raspberrypi/conf/machine/raspberrypi4.conf` - line number 22
      `-VC4DTBO ?= "vc4-kms-v3d"`
      `+VC4DTBO ?= "vc4-fkms-v3d"`

# bitbake command for compilation

```sh
bitbake microfabricator-image
```


# installing image in SDCARD

path to the image file as below:
`cd tmp/deploy/images/raspberrypi4`

flash the image in sdcard as below:
`sudo dd if=./microfabricator-image-raspberrypi4.rpi-sdimg of=/dev/sdX` X-will be your file system (ex: sda,sdb,etc..)

