#!/bin/sh -e

SCRIPT_DIR="$(cd $(dirname ${0}); pwd)"
WORK_DIR="${SCRIPT_DIR}/../local"

ZIP="${WORK_DIR}/noobs.zip"
if [ ! -f "${ZIP}" ]; then
    #wget http://downloads.raspberrypi.org/NOOBS_latest -O ${ZIP}
    wget http://downloads.raspberrypi.org/NOOBS_lite_latest -O ${ZIP}
fi

DIR="${WORK_DIR}/noobs"
if [ ! -d "${DIR}" ]; then
    unzip ${ZIP} -d ${DIR}
fi

diskutil unmountDisk /dev/disk2
sudo diskutil eraseDisk FAT32 NOOBS MBRFormat /dev/disk2
cp -R ${DIR}/* /Volumes/NOOBS/
diskutil unmountDisk /dev/disk2
