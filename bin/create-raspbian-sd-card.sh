#!/bin/sh -e 

SCRIPT_DIR=$(cd "$(dirname "${0}")"; pwd)
WORK_DIR="${SCRIPT_DIR}/../local"
ARCHIVE="${WORK_DIR}/raspbian.zip"
IMAGE="${WORK_DIR}/raspbian.img"
HASH="cb799af077930ff7cbcfaa251b4c6e25b11483de"
TARGET="disk2"

if [ ! -f "${ARCHIVE}" ]; then
    wget http://downloads.raspberrypi.org/raspbian_latest -O ${ARCHIVE}
fi

if [ ! -f "${IMAGE}" ]; then
    unzip -p "${ARCHIVE}" "*.img" | cat > "${IMAGE}"
fi

CHECKSUM=$(sha1sum ${IMAGE} | awk '{ print $1 }' )

if [ "${CHECKSUM}" = "${HASH}" ]; then
    echo "Checksum failed."

    exit 1
fi

diskutil list
echo "TARGET: ${TARGET}"
echo "Continue? [y/N]"
read CONTINUE

if [ ! "${CONTINUE}" = "y" ]; then
    echo "User abort."

    exit 1
fi

diskutil unmountDisk "/dev/${TARGET}"
sudo diskutil partitionDisk "/dev/${TARGET}" 1 MBR "Free Space" %noformat% 100%
sudo dd bs=1m "if=${IMAGE}" "of=/dev/r${TARGET}"
sudo diskutil eject "/dev/r${TARGET}"
