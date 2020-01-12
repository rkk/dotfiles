#!/bin/sh
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

if [ ! -f "/etc/doas.conf" ]; then
    echo "permit persist :wheel" > "${TMPDIR}/tmpdoas"
    echo "ERROR: doas not configured."
    echo "       Switch to root using 'su -' and run"
    echo "       the command 'cp ${TMPDIR}/tmpdoas /etc/doas.conf'"
    echo ""
    exit 1
fi

if [ ! -f "/etc/installurl" ]; then
    installtmp="${TMPDIR}/installtmp"
    echo "https://ftp.openbsd.org/pub/OpenBSD" > "${installtmp}"
    doas cp "${installtmp}" /etc/installurl
    rm "${installtmp}"
fi

packages="${packages} dmenu curl sakura vim-8.0.0987p0-no_x11-perl-python3-ruby"
packages="${packages} xclip go redshift bash i3 rxvt-unicode ectags w3m"
packages="${packages} cabextract newsbeuter xbanish qutebrowser shellcheck"

for package in ${packages}
do
    doas pkg_add "${package}"
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

# Fuzzy Finder (fzf).
if [ ! -d "${HOME}/.fzf" ]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
fi

# XDG directories.
if [ ! -d "${HOME}/.config" ]; then
    mkdir -p "${HOME}/.config"
fi

# Fixes for Linuxisms and Bashisms.
if [ ! -f /bin/bash ]; then
    if [ -f /usr/local/bin/bash ]; then
        doas ln -s /usr/local/bin/bash /bin/bash
    fi
fi

if [ ! -f /usr/bin/xrdb ]; then
    if [ -f /usr/X11R6/bin/xrdb ]; then
        doas ln -s /usr/X11R6/bin/xrdb /usr/bin/xrdb
    fi
fi

# Ports system for that which is not in packages.
portstmp="${TMPDIR}/ports.tar.gz"
portsdir="/usr/ports"
if [ ! -d "${portsdir}" ]; then
    ftp "mirrors.dotsrc.org/pub/OpenBSD/$(uname -r)/ports.tar.gz -o ${portstmp}"
    doas tar xzf "${portstmp}" -C /usr
fi


echo "Done."

