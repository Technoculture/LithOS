# yocto-microfabricator envrionment setup

1. mkdir repo <br />

2. cd repo <br />

3. repo init -u https://github.com/TechnocultureResearch/yocto-microfabricator -b kirkstone -m kirkstone.xml <br />

4. repo sync -j16 <br />

# yocto-microfabricator compilation setup
5. mkdir rpi <br />

6. Execute the below command for envrionment setup <br />

source poky-kirkstone/oe-init-build-env ./rpi/build

7. copy the conf files as below <br />

a) cp -rp ../../poky-kirkstone/meta-microfabricator/custom/local.conf.sample conf/local.conf <br />
   
b) cp -rp ../../poky-kirkstone/meta-microfabricator/custom/bblayers.conf.sample conf/bblayers.conf <br />
   
# modify the source files
8. update the following files <br />

   1)for auto login: <br />

   gedit ../../poky-kirkstone/meta/recipes-core/systemd/systemd-serialgetty/serial-getty@.service - line number 34 <br />

   -ExecStart=-/sbin/agetty -8 -L %I @BAUDRATE@ $TERM  <br />

   +ExecStart=-/sbin/agetty -a root -8 -L %I @BAUDRATE@ $TERM <br />

   2)for eglfs and touch: <br />

   a)gedit ../../poky-kirkstone/meta-raspberrypi/recipes-bsp/bootfiles/rpi-config_git.bb - line number 27  <br />

   VC4GRAPHICS="${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "1", "0", d)}" <br />
   -VC4DTBO ?= "vc4-kms-v3d" <br />
   +VC4DTBO ?= "vc4-fkms-v3d" <br />


   b)gedit ../../poky-kirkstone/meta-raspberrypi/conf/machine/raspberrypi4.conf - line number 22 <br />
   -VC4DTBO ?= "vc4-kms-v3d" <br />
   +VC4DTBO ?= "vc4-fkms-v3d" <br />


# bitbake command for compilation

bitbake microfabricator-image <br />

# installing image in SDCARD

path to the image file as below: <br />
1.cd tmp/deploy/images/raspberrypi4 <br />

flash the image in sdcard as below: <br />
2.sudo dd if=./microfabricator-image-raspberrypi4.rpi-sdimg of=/dev/sdX X-will be your file system (ex: sda,sdb,etc..)

