#!/bin/bash
#
# Installs the packages and tools that make up the environment.
# The script is designed to be idempotent, so no side effects
# are expected, if run multiple times.
#

# Install items for Linux.
function install_linux {
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

    install_dvorarkk
    install_go_fonts
    install_microsoft_fonts
    install_fzf
    install_go_linux

    setup_newsbeuter
    setup_weechat_slack
    setup_git_aliases

    echo ""
    echo "Done."
    echo ""
}


# Install items for OpenBSD.
function install_openbsd {
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
    packages="${packages} xclip go redshift bash i3 ectags w3m"
    packages="${packages} cabextract newsbeuter xbanish qutebrowser shellcheck"

    for package in ${packages}
    do
        doas pkg_add "${package}"
        install_res=${?}
        if [ "${install_res}" -ne 0 ]; then
            echo "ERROR: Cannot install package ${package}"
        fi
    done

    install_dvorarkk
    install_go_fonts
    install_microsoft_fonts
    install_fzf
    setup_git_aliases

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

    echo ""
    echo "Done."
    echo ""
}

# Install items for Mac OS X.
function install_mac {
    brew_packages="tmux watch gnu-tar reattach-to-user-namespace"
    brew_packages="${brew_packages} w3m wget"
    brew_packages="${brew_packages} shellcheck ctags docker"

    brew_cmd="/usr/local/bin/brew"
    FONT_ROOT="${HOME}/Library/Fonts"
    if [ ! -f ${brew_cmd} ]; then
      echo "ERROR: Homebrew is not installed"
      exit 1
    fi

    ${brew_cmd} update
    update_res="${?}"
    if [ "${update_res}" -ne 0 ]; then
        echo "ERROR: Cannot update Homebrew"
        exit 1
    fi

    for p in ${brew_packages}
    do
      ${brew_cmd} install "${p}"
      install_res="${?}"
      if [ "${install_res}" -ne 0 ]; then
        echo "ERROR: Cannot install brew package ${p}"
      fi
    done
    if [ ! -d "${FONT_ROOT}" ]; then
        mkdir -p "${FONT_ROOT}"
    fi

    font_tar="${TMPDIR}/ttfs.tar.gz"
    curl -sS "https://go.googlesource.com/image/+archive/master/font/gofont/ttfs.tar.gz" > "${font_tar}"
    tar xzf "${font_tar}" -C "${FONT_ROOT}"
    if [ -f "${font_tar}" ]; then
        rm -f "${font_tar}"
    fi

    install_dvorarkk
    install_fzf
    setup_git_aliases

    echo ""
    echo "Done."
    echo ""
}

# Install Go fonts.
function install_go_fonts {
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
}

# Install Microsoft core fonts.
function install_microsoft_fonts {
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
}

# Install Fuzzy Finder (fzf).
function install_fzf {
    if [ ! -d "${HOME}/.fzf" ]; then
        git clone https://github.com/junegunn/fzf.git ~/.fzf
    fi
}

# Install Go (golang), latest version for AMD64.
# Shamelessly adapted from github.com/jessfraz/dotfiles/bin/install.sh.
function install_go_linux {
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
}

# Install Dvorarkk keyboard layout.
function install_dvorarkk {
    dvorarkk_dir="${HOME}/Frameworks/Dvorarkk"
    if [ ! -d "${dvorarkk_dir}" ]; then
        mkdir -p "${dvorarkk_dir}"
        git clone https://github.com/rkk/Dvorarkk.git "${dvorarkk_dir}"
    fi
}


# Set up the needed config directories for Newsbeuter.
function setup_newsbeuter {
    if [ -d "${HOME}/.config/newsbeuter" ]; then
        if [ ! -d "${HOME}/.local/share/newsbeuter" ]; then
            ln -s "${HOME}/.config/newsbeuter" "${HOME}/.local/share/newsbeuter"
        fi
    fi
}

# Set up Weechat with Slack integration.
function setup_weechat_slack {
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
}

# Set up Git aliases; avoid changing the Git config file directly.
function setup_git_aliases {
    git config --global alias.b "branch"
    git config --global alias.ba "branch -ar"
    git config --global alias.c "checkout"
    git config --global alias.d "diff --word-diff"
    git config --global alias.f "fetch --all"
    git config --global alias.n "log --name-only"
    git config --global alias.new "checkout -b"
    git config --global alias.l "log --decorate --oneline"
    git config --global alias.s "status"
    git config --global alias.r "remote -v show"
    git config --global alias.unstage "reset HEAD --"
}


#
# MAIN
#

os=$(uname)

case "${os}" in
    "Linux")
        install_linux
        ;;
    "OpenBSD")
        install_openbsd
        ;;
    "Darwin")
        install_mac
        ;;
    "*")
        echo "ERROR: Operating system not supported"
        exit 2
        ;;
esac

