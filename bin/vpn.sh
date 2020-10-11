#!/bin/sh
#
# Starts an OpenVPN connection.
#

openvpn="/usr/local/sbin/openvpn"
openvpn_alt="/usr/sbin/openpvn"
connection="/etc/openvpn/default.conf"

if [ ! -f "${openvpn}" ]; then
	if [ ! -f "${openvpn_alt}" ]; then
        echo "ERROR: OpenVPN not installed at ${openvpn} and neither at ${openvpn_alt}"
    	exit 1
    fi
    openvpn="${openvpn_alt}"
fi

if [ ! -f "${connection}" ]; then
    echo "ERROR: Configuration file not found: ${connection}"
    exit 1
fi

if [ $(uname -s) = "OpenBSD" ]; then
    doas ${openvpn} --config ${connection}
fi

if [ $(uname -s) = "Linux" ]; then
	sudo "${openvpn}" --config "${connection}"
fi


