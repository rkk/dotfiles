#!/bin/bash
#
# Installs Apt packages in Ubuntu.
# The script is designed to be idempotent, so no
# side effects are expected if run multiple times.
#

TMPDIR=${TMPDIR:-/tmp}

apt_packages="tmux vim ruby git-core i3-wm i3-lock i3status mksh"
apt_packages="${apt_packages} dmenu curl sakura"
apt_packages="${apt_packages} network-manager network-manager-openvpn"
apt_packages="${apt_packages} network-manager-openvpn-gnome"
apt_packages="${apt_packages} whois autotools-dev automake libevent-dev"
apt_packages="${apt_packages} libncurses5-dev exuberant-ctags"
apt_packages="${apt_packages} python-pip xclip golang"

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

echo "Done."

