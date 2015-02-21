#!/bin/sh -e

usage () {
    echo "usage : ${0} NEW_HOSTNAME"
    exit 1
}

[ -z $1 ] && usage

OLD_HOSTNAME=`hostname`
NEW_HOSTNAME="${1}"

FILES="/etc/exim4/update-exim4.conf.conf
/etc/printcap
/etc/hostname
/etc/hosts
/etc/ssh/ssh_host_rsa_key.pub
/etc/ssh/ssh_host_dsa_key.pub
/etc/motd
/etc/ssmtp/ssmtp.conf"

for FILE in ${FILES}; do
    if [ -f "${FILE}" ]; then
        echo "Updating ${FILE}"
        sed -i -e "s:${OLD_HOSTNAME}:${NEW_HOSTNAME}:g" "${FILE}"
    fi
done

echo "Now restart your system. This is not an option."
