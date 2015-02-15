#!/bin/sh
diskutil unmountDisk /dev/disk2
sudo diskutil eraseDisk FAT32 NOOBS MBRFormat /dev/disk2
#wget http://downloads.raspberrypi.org/NOOBS_latest -O noobs.zip
#unzip noobs.zip -d noobs
wget http://downloads.raspberrypi.org/NOOBS_lite_latest -O noobs-lite.zip
unzip noobs-lite.zip -d noobs
cp -R noobs/* /Volumes/NOOBS/
diskutil unmountDisk /dev/disk2
