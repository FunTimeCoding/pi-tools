# pi-tools


## Setup

Run initial setup on a new pi.

```sh
fab -u pi -k -H 192.168.2.125 setup
```


### Raspbian

Install Raspbian on a SD card.

```
diskutil unmountDisk /dev/disk2
wget http://downloads.raspberrypi.org/raspbian_latest -O raspbian.img.zip
unzip raspbian.img.zip -d raspbian.img
sudo diskutil partitionDisk /dev/disk2 1 MBR "Free Space" "%noformat%" 100%
sudo dd bs=1m if=raspbian.img of=/dev/rdisk2
sudo diskutil eject /dev/rdisk2
```


### Noobs

Install NOOBS on a SD card.

```sh
diskutil unmountDisk /dev/disk2
sudo diskutil eraseDisk FAT32 NOOBS MBRFormat /dev/disk2
#wget http://downloads.raspberrypi.org/NOOBS_latest -O noobs.zip
#unzip noobs.zip -d noobs
wget http://downloads.raspberrypi.org/NOOBS_lite_latest -O noobs-lite.zip
unzip noobs-lite.zip -d noobs
cp -R noobs/* /Volumes/NOOBS/
diskutil unmountDisk /dev/disk2
```
