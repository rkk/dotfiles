#!/bin/bash
#
# Installs Apt packages in Debian.
# The script is designed to be idempotent, so no
# side effects are expected if run multiple times.
#

if [ "$(uname)" != "Linux" ]; then
    echo "Unsupported operating system"
    exit 2
fi


TMPDIR=${TMPDIR:-/tmp}
FONT_ROOT="${HOME}/.local/share/fonts"

if [ ! -d "${TMPDIR}" ]; then
    mkdir -p "${TMPDIR}"
fi

apt_packages="tmux vim ruby git-core i3-wm i3status"
apt_packages="${apt_packages} dmenu curl mutt"
apt_packages="${apt_packages} whois autotools-dev automake libevent-dev"
apt_packages="${apt_packages} libncurses5-dev exuberant-ctags"
apt_packages="${apt_packages} python-pip xclip"
apt_packages="${apt_packages} cabextract openssh-server"
apt_packages="${apt_packages} shellcheck sxhkd rofi"
apt_packages="${apt_packages} sakura xterm"

sudo apt-get update
for package in ${apt_packages}
do
    sudo apt-get install -y "${package}"
    install_res=${?}
    if [ "${install_res}" -ne 0 ]; then
        echo "ERROR: Cannot install Apt package ${package}"
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
if [ ! -f "${FONT_ROOT}/verdana.ttf" ]; then
    if [ ! -d "${TMPDIR}/corefonts" ]; then
        git clone https://github.com/pushcx/corefonts "${TMPDIR}/corefonts"
    for f in "${TMPDIR}"/corefonts/*exe
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


echo "Done."

