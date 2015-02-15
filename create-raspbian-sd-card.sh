#!/bin/sh
diskutil unmountDisk /dev/disk2
wget http://downloads.raspberrypi.org/raspbian_latest -O raspbian.img.zip
unzip raspbian.img.zip -d raspbian.img
sudo diskutil partitionDisk /dev/disk2 1 MBR "Free Space" "%noformat%" 100%
sudo dd bs=1m if=raspbian.img of=/dev/rdisk2
sudo diskutil eject /dev/rdisk2
