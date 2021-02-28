#!/bin/sh
#
# Monitors the X11 inputs and runs specific scripts when changes
# occur - handy for applying custom keyboard or mouse settings after
# X11 starts, or hardware is added/removed.

run_action() {
    "${HOME}/bin/setdvorarkk"
    "${HOME}/bin/setmouse"
}

make_monitor() {
    f="${1}"
    if [ "x${1}" = "x" ]; then
        return
    fi
    xinput list > "${f}"
}

if [ "x${TMPDIR}" = "x" ]; then
    echo "ERROR: Environment variable TMPDIR not set."
    exit 1
fi

monitor="${TMPDIR}/keyboardwarrior.monitor"
tmp="${monitor}.tmp"
interval="15"

if [ ! -f "{monitor}" ]; then
    make_monitor "${monitor}"
fi

while :
do
    make_monitor "${tmp}"
    if [ ! -f "${monitor}" ]; then
        echo "ERROR: Monitor file ${monitor} missing."
        exit 1
    fi
    if [ ! -f "${tmp}" ]; then
        echo "ERROR: Temporary monitor file ${tmp} missing."
        exit 1
    fi
    if [ "$(diff "${monitor}" "${tmp}")" ]; then
        run_action
        mv -f "${tmp}" "${monitor}"
    fi
    sleep "${interval}"
done

