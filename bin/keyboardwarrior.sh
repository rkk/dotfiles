#!/bin/sh
#
# Monitors the X11 inputs and runs specific scripts when changes
# occur - handy for applying custom keyboard or mouse settings after
# X11 starts, or hardware is added/removed.

run_action() {
    "${HOME}/bin/setdvorarkk"
    "${HOME}/bin/setmouse"
}

make_semaphor() {
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

semaphor="${TMPDIR}/keyboardwarrior.monitor"
tmp="${semaphor}.tmp"
interval="15"

if [ ! -f "{semaphor}" ]; then
    make_semaphor "${semaphor}"
fi

while :
do
    make_semaphor "${tmp}"
    if [ ! -f "${semaphor}" ]; then
        echo "ERROR: Semaphor file ${semaphor} missing."
        exit 1
    fi
    if [ ! -f "${tmp}" ]; then
        echo "ERROR: Temporary semaphor file ${tmp} missing."
        exit 1
    fi
    if [ "$(diff "${semaphor}" "${tmp}")" ]; then
        run_action
        mv -f "${tmp}" "${semaphor}"
    fi
    sleep "${interval}"
done

