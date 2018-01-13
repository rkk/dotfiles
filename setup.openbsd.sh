#!/bin/ksh
#
# Installs packages in OpenBSD.
# The script is designed to be idempotent, so no
# side effects are expected if run multiple times.
#

if [ "$(uname)" != "OpenBSD" ]; then
    echo "Unsupported operating system"
    exit 2
fi

TMPDIR=${TMPDIR:-/tmp}
FONT_ROOT="${HOME}/.local/share/fonts"

# Requires the file /etc/installurl to contain only the following,
#
# https://ftp.openbsd.org/pub/OpenBSD
#
# (EOM).

packages="${packages} dmenu curl sakura"
packages="${packages} xclip go redshift rofi"
packages="${packages} cabextract newsbeuter mc"

for package in ${packages}
do
    doas pkg_add "${package}"
TMPDIR=${TMPDIR:-/tmp}
    install_res=${?}
    if [ "${install_res}" -ne 0 ]; then
        echo "ERROR: Cannot install package ${package}"
    fi
done


# Dvorarkk keyboard layout.
dvorarkk_dir="${HOME}/Frameworks/Dvorarkk"
if [ ! -d "${dvorarkk_dir}" ]; then
    mkdir -p "${dvorarkk_dir}"
    git clone https://github.com/rkk/Dvorarkk.git "${dvorarkk_dir}"
fi

# Golang fonts.
if [ ! -d "${FONT_ROOT}" ]; then
    mkdir -p "${FONT_ROOT}"
fi

if [ ! -f "${FONT_ROOT}/Go-Mono.ttf" ]; then
    font_tar="${TMPDIR}/ttfs.tar.gz"
    curl -sS "https://go.googlesource.com/image/+archive/master/font/gofont/ttfs.tar.gz" > "${font_tar}"
    tar xzf "${font_tar}" -C "${FONT_ROOT}"
    if [ -f "${font_tar}" ]; then
        rm -f "${font_tar}"
    fi
fi

# Microsoft core fonts.
if [ ! -f "${FONT_ROOT}/webdings.ttf" ]; then
    if [ ! -d "${TMPDIR}/corefonts" ]; then
        git clone https://github.com/pushcx/corefonts "${TMPDIR}/corefonts"
        for f in ${TMPDIR}/corefonts/*exe
        do
            cabextract -d "${FONT_ROOT}" -q -L -F "*.TTF" "${f}"
        done
        rm -rf "${TMPDIR}/corefonts"
    fi
fi


echo "Done."

