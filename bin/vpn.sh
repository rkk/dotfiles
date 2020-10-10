#!/bin/sh
#
# Starts an OpenVPN connection.
#

openvpn="/usr/local/sbin/openvpn"
connection="/etc/openvpn/default.conf"

if [ ! -f "${openvpn}" ]; then
    echo "ERROR: OpenVPN not installed at ${openvpn}"
    exit 1
fi

if [ ! -f "${connection}" ]; then
    echo "ERROR: Configuration file not found: ${connection}"
    exit 2
fi

if [ "$(uname -s)" = "OpenBSD" ]; then
    doas ${openvpn} --config ${connection}
    exit 0
fi

sudo "${openvpn}" --config "${connection}"
