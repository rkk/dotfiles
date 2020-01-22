#!/bin/bash
#
# Installs the packages and tools that make up the environment.
# The script is designed to be idempotent, so no side effects
# are expected, if run multiple times.
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

apt_packages="tmux vim ruby git i3-wm i3status i3lock"
apt_packages="${apt_packages} dmenu curl mutt"
apt_packages="${apt_packages} whois autotools-dev automake libevent-dev"
apt_packages="${apt_packages} libncurses5-dev exuberant-ctags"
apt_packages="${apt_packages} python-pip xclip"
apt_packages="${apt_packages} cabextract openssh-server"
apt_packages="${apt_packages} shellcheck sxhkd rofi"
apt_packages="${apt_packages} sakura xterm newsbeuter"
apt_packages="${apt_packages} firefox qutebrowser w3m jq net-tools"
apt_packages="${apt_packages} dnsutils coreutils gzip zip unzip bzip2 xz-utils"
apt_packages="${apt_packages} weechat weechat-python python-websocket"

sudo apt-get update
for package in ${apt_packages}
do
    sudo apt-get install -y "${package}"
    install_res=${?}
    if [ "${install_res}" -ne 0 ]; then
        echo "ERROR: Cannot install Apt package ${package}"
    fi
done

sudo apt autoremove
sudo apt autoclean
sudo apt clean

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

# Install Go (golang), latest version for AMD64.
# Shamelessly adapted from github.com/jessfraz/dotfiles/bin/install.sh.
GO_SRC="/usr/local/go"
if [ ! -d "${GO_SRC}" ]; then
    GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")
    GO_VERSION=${GO_VERSION#go}
    (
    kernel=$(uname -s | tr '[:upper:]' '[:lower:]')
    curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.${kernel}-amd64.tar.gz" | sudo tar -v -C /usr/local -xz
    )

    export PATH="${PATH}:/usr/local/go/bin"
    go get golang.org/x/lint/golint
    go get golang.org/x/tools/cmd/cover
    go get golang.org/x/review/git-codereview
    go get golang.org/x/tools/cmd/goimports
    go get golang.org/x/tools/cmd/gorename
    go get golang.org/x/tools/cmd/guru
    go get github.com/jstemmer/gotags
    go get github.com/nsf/gocode
    go get github.com/rogpeppe/godef
fi

# Post-install fixes.
if [ -d "${HOME}/.config/newsbeuter" ]; then
    if [ ! -d "${HOME}/.local/share/newsbeuter" ]; then
        ln -s "${HOME}/.config/newsbeuter" "${HOME}/.local/share/newsbeuter"
    fi
fi

if [ ! -d "${HOME}/.weechat/python/autoload" ]; then
    mkdir -p "${HOME}/.weechat/python/autoload"
    curl -sSL "https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py" > "${HOME}/.weechat/python/wee_slack.py"
    ln -s "${HOME}/.weechat/python/wee_slack.py" "${HOME}/.weechat/python/autoload/wee_slack.py"
    echo "IMPORTANT: Weechat needs your Slack API keys"
    echo "IMPORTANT: Run 'weechat', load the wee_slack module: '/python load wee_slack.py'"
    echo "IMPORTANT: In Weechat, open the register URL: '/slack register'"
    echo "IMPORTANT: Copy the 'code' URL parameter from the failing URL (is expected) in your browser"
    echo "IMPORTANT: In Weechat, register the code: '/slack register <paste the code>'"
    echo ""
fi


echo "Done."

