#!/bin/sh
#
# Starts an OpenVPN connection.
#

candidates="/usr/local/sbin/openvpn /usr/sbin/openvpn"
connection="/etc/openvpn/default.conf"

cmd=""
for f in ${candidates}
do
    if [ -f "${f}" ]; then
        cmd="${f}"
    fi
done

if [ "x${cmd}" = "x" ]; then
    echo "ERROR: Cannot locate openvpn."
    exit 1
fi

if [ ! -f "${connection}" ]; then
    echo "ERROR: Configuration file not found: ${connection}"
    exit 1
fi

if [ "$(uname -s)" = "OpenBSD" ]; then
    doas "${cmd}" --config "${connection}"
    exit 0
fi

if [ "$(uname -s)" = "Linux" ]; then
	sudo "${cmd}" --config "${connection}"
fi
