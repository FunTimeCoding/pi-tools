#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}"; pwd)
WORK_DIRECTORY="${SCRIPT_DIRECTORY}/../tmp"
ARCHIVE="${WORK_DIRECTORY}/raspbian.zip"
IMAGE="${WORK_DIRECTORY}/raspbian.img"
HASH=64c4103316efe2a85fd2814f2af16313abac7d4ad68e3d95ae6709e2e894cc1b
TARGET=disk2
mkdir -p "${WORK_DIRECTORY}"

if [ ! -f "${ARCHIVE}" ]; then
    wget --output-document "${ARCHIVE}" http://downloads.raspberrypi.org/raspbian_latest
fi

if [ ! -f "${IMAGE}" ]; then
    unzip -p "${ARCHIVE}" "*.img" | cat > "${IMAGE}"
fi

SYSTEM=$(uname)

if [ "" = Darwin ]; then
    SHA256SUM=gsha256sum
else
    SHA256SUM=sha256sum
fi

CHECKSUM=$(${SHA256SUM} "${IMAGE}" | awk '{ print $1 }' )

if [ "${CHECKSUM}" = "${HASH}" ]; then
    echo "Checksum failed."

    exit 1
fi

diskutil list
echo "TARGET: ${TARGET}"
echo "Continue? [y/N]"
read CONTINUE

if [ ! "${CONTINUE}" = y ]; then
    echo "User abort."

    exit 1
fi

diskutil unmountDisk "/dev/${TARGET}"
sudo diskutil partitionDisk "/dev/${TARGET}" 1 MBR "Free Space" %noformat% 100%
sudo dd bs=1m "if=${IMAGE}" "of=/dev/r${TARGET}"
sudo diskutil eject "/dev/r${TARGET}"
