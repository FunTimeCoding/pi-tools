#!/bin/sh -e

usage () {
    echo "usage: sudo ${0} [-hv][-n NETWORK_DEVICE] FQDN"
}

NETWORK_DEVICE="eth0"

while getopts "hvn:" OPT; do
    case "$OPT" in
        h)
            usage
            exit 0
            ;;
        n)
            NETWORK_DEVICE="$OPTARG"
            shift 2
            ;;
        v)
            set -x
            shift
            ;;
    esac
done

if [ "$(ifconfig ${NETWORK_DEVICE} | grep ${NETWORK_DEVICE})" = "" ]; then
    echo "Invalid network device."
    exit 1
fi

if [ "${1}" = "" ]; then
    usage
    exit 1
fi

if [ ! "$(id -u)" = "0" ]; then
    usage
    exit 1
fi

VALIDATED=$(echo "${1}" | grep -P '(?=^.{1,254}$)(^(?:(?!\d+\.)[a-zA-Z0-9_\-]{1,63}\.?)+(?:[a-zA-Z]{2,})$)')

if [ "${VALIDATED}" = "" ]; then
    echo "Invalid FQDN."
    exit 1
fi

IP=$(ifconfig ${NETWORK_DEVICE} | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}')

if [ "${IP}" = "" ]; then
    echo "Invalid IP."
    exit 1
fi

HOSTNAME=$(echo "${VALIDATED}" | cut -d '.' -f 1)

if [ "${HOSTNAME}" = "" ]; then
    echo "Invalid hostname."
    exit 1
fi

echo "Old hosts file:"
cat /etc/hosts

echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
echo "${IP} ${VALIDATED} ${HOSTNAME}" >> /etc/hosts

echo "New hosts file:"
cat /etc/hosts
