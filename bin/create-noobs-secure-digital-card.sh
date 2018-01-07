#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)
WORK_DIRECTORY="${SCRIPT_DIRECTORY}/../local"
ARCHIVE="${WORK_DIRECTORY}/noobs.zip"
DIRECTORY="${WORK_DIRECTORY}/noobs"

if [ ! -f "${ARCHIVE}" ]; then
    #wget http://downloads.raspberrypi.org/NOOBS_latest -O ${ARCHIVE}
    wget http://downloads.raspberrypi.org/NOOBS_lite_latest -O ${ARCHIVE}
fi

if [ ! -d "${DIRECTORY}" ]; then
    unzip -p "${ARCHIVE}" "*.img" | cat > "${IMG}"
fi

diskutil unmountDisk /dev/disk2
sudo diskutil eraseDisk FAT32 NOOBS MBRFormat /dev/disk2
cp -R ${DIRECTORY}/* /Volumes/NOOBS
diskutil unmountDisk /dev/disk2
