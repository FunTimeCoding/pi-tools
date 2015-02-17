#!/bin/sh

ZIP="raspbian.zip"
if [ ! -f "${ZIP}" ]; then
    wget http://downloads.raspberrypi.org/raspbian_latest -O ${ZIP}
fi

IMG="raspbian.img"
if [ ! -f "${IMG}" ]; then
    unzip ${ZIP} -d ${IMG}
fi

diskutil unmountDisk /dev/disk2
sudo diskutil partitionDisk /dev/disk2 1 MBR "Free Space" "%noformat%" 100%
sudo dd bs=1m if=${IMG} of=/dev/rdisk2
sudo diskutil eject /dev/rdisk2
