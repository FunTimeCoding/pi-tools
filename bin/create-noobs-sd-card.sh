#!/bin/sh -e

DIR=$(dirname "${0}")
SCRIPT_DIR=$(cd "${DIR}"; pwd)
WORK_DIR="${SCRIPT_DIR}/../local"
ZIP="${WORK_DIR}/noobs.zip"
DIR="${WORK_DIR}/noobs"

if [ ! -f "${ZIP}" ]; then
    #wget http://downloads.raspberrypi.org/NOOBS_latest -O ${ZIP}
    wget http://downloads.raspberrypi.org/NOOBS_lite_latest -O ${ZIP}
fi

if [ ! -d "${DIR}" ]; then
    unzip -p "${ZIP}" "*.img" | cat > "${IMG}"
fi

diskutil unmountDisk /dev/disk2
sudo diskutil eraseDisk FAT32 NOOBS MBRFormat /dev/disk2
cp -R ${DIR}/* /Volumes/NOOBS/
diskutil unmountDisk /dev/disk2
