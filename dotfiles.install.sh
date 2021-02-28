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
    APT_BACKPORT="/etc/apt/sources.list.d/buster-backports.list"

    if [ ! -d "${TMPDIR}" ]; then
        mkdir -p "${TMPDIR}"
    fi

    if [ ! -f "${APT_BACKPORT}" ]; then
        echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" | sudo tee -a "${APT_BACKPORT}"
    fi

    # Basics
    apt_packages="tmux vim ruby git curl firmware-misc-nonfree mc"

    # X11 and window manager
    apt_packages="${apt_packages} i3-wm i3status i3lock sxhkd xdotool rxvt-unicode"
    apt_packages="${apt_packages} meson libxcb-shape0-dev libstartup-notification0-dev libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool"
    apt_packages="${apt_packages} libxcb-xrm-dev"
    apt_packages="${apt_packages} rofi wmctrl brightnessctl xorg-dev"
    apt_packages="${apt_packages} libx11-dev xclip xterm sakura xautolock"
    apt_packages="${apt_packages} autocutsel dmenu polybar xinput scrot"

    # Development tools
    apt_packages="${apt_packages} whois autotools-dev automake libevent-dev"
    apt_packages="${apt_packages} libncurses5-dev exuberant-ctags"
    apt_packages="${apt_packages} shellcheck jq"
    apt_packages="${apt_packages} python-pip python3-pip"

    # Web
    apt_packages="${apt_packages} firefox-esr qutebrowser chromium w3m"
    apt_packages="${apt_packages} newsbeuter pandoc"

    # Other
    apt_packages="${apt_packages} redshift sxiv"

    # System
    apt_packages="${apt_packages} dnsutils coreutils xz-utils zathura"
    apt_packages="${apt_packages} docker.io docker-doc"
    apt_packages="${apt_packages} acpi net-tools openssh-server"

    # Required by dotfiles installation script
    apt_packages="${apt_packages} cabextract gzip zip unzip bzip2"

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
    install_plan9port_linux
    install_spotify_linux
    install_i3gaps_linux

    setup_newsbeuter
    setup_git_aliases
    setup_firefox
    setup_vim
    setup_zathura
    setup_plan9port
    setup_i3
    setup_docker_linux
    setup_timezone_linux

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
    setup_vim

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
    setup_vim

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
    go get -u github.com/junegunn/fzf
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
        export GOPATH="${HOME}/go"
        if [ ! -f "${GOPATH}" ]; then
            mkdir -p "${GOPATH}"
        fi
        go get golang.org/x/lint/golint
        go get golang.org/x/tools/cmd/cover
        go get golang.org/x/review/git-codereview
        go get golang.org/x/tools/cmd/goimports
        go get golang.org/x/tools/cmd/gorename
        go get golang.org/x/tools/cmd/guru
        go get github.com/jstemmer/gotags
        go get github.com/nsf/gocode
        go get github.com/rogpeppe/godef
        # Private tools written in Go, but not needed by Go.
        go get github.com/rkk/teleprompt
    fi
}

# Install Plan9port.
function install_plan9port_linux {
    clone_url="https://github.com/9fans/plan9port"
    plan9port_root="/usr/local/plan9"
    if [ -d "${plan9port_root}" ]; then
        return
    fi
    sudo mkdir -p "${plan9port_root}"
    u="$(id -u -n)"
    g="$(id -g -n)"
    sudo chown "${u}:${g}" "${plan9port_root}"
    git clone "${clone_url}" "${plan9port_root}"
}

# Install Spotify client.
function install_spotify_linux {
    if [ -f /usr/bin/spotify ]; then
        return
    fi
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install -y spotify-client
}


# Install i3-gaps.
function install_i3gaps_linux {
    start_dir="${PWD}"
    # shellcheck disable=SC2164
    cd "${TMPDIR}"
    if [ -d i3-gaps ]; then
    	# shellcheck disable=SC2164
    	cd "${start_dir}"
        return
    fi
    git clone https://www.github.com/Airblader/i3 i3-gaps
    # shellcheck disable=SC2164
    cd i3-gaps
    git checkout gaps && git pull
    meson build -Dprefix=/usr
    cd build || return
    sudo ninja install
    sudo ninja clean
    # shellcheck disable=SC2164
    cd "${start_dir}"
}

# Install Dvorarkk keyboard layout.
function install_dvorarkk {
    dvorarkk_dir="${XDG_CONFIG_HOME}/dvorarkk"
    if [ ! -d "${dvorarkk_dir}" ]; then
        git clone https://github.com/rkk/Dvorarkk.git "${dvorarkk_dir}"
    fi
}

# Set up the needed config directories for Newsbeuter.
function setup_newsbeuter {
    if [ -d "${XDG_CONFIG_HOME}/newsbeuter" ]; then
        if [ ! -d "${HOME}/.local/share/newsbeuter" ]; then
            ln -s "${XDG_CONFIG_HOME}/newsbeuter" "${HOME}/.local/share/newsbeuter"
        fi
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


# Set up Qutebrowser as default browser.
function setup_qutebrowser {
    xdg-settings set default-web-browser qutebrowser.desktop
}


# Set up Firefox as default browser.
function setup_firefox {
    xdg-settings set default-web-browser firefox.desktop
}


# Set up Vi(m).
function setup_vim {
    BUNDLE_ROOT="${HOME}/.vim/bundle"
    AUTOLOAD_ROOT="${HOME}/.vim/autoload"
    PATHOGEN_VIM="${AUTOLOAD_ROOT}/pathogen.vim"
    BACKUP_ROOT="${HOME}/.vim/backup"
    TMP_ROOT="${HOME}/.vim/tmp"

    if [ ! -d "${BUNDLE_ROOT}" ]; then
        mkdir -p "${BUNDLE_ROOT}"
    fi

    if [ ! -d "${AUTOLOAD_ROOT}" ]; then
        mkdir -p "${AUTOLOAD_ROOT}"
    fi

    if [ ! -d "${BACKUP_ROOT}" ]; then
        mkdir -p "${BACKUP_ROOT}"
    fi

    if [ ! -d "${TMP_ROOT}" ]; then
        mkdir -p "${TMP_ROOT}"
    fi

    if [ ! -f "${PATHOGEN_VIM}" ]; then
        curl -LSso "${PATHOGEN_VIM}" https://tpo.pe/pathogen.vim
    fi

    if [ ! -d "${BUNDLE_ROOT}/vim-fugitive" ]; then
        git clone git://github.com/tpope/vim-fugitive.git "${BUNDLE_ROOT}/vim-fugitive"
    fi

    if [ ! -d "${BUNDLE_ROOT}/tagbar" ]; then
        git clone git://github.com/majutsushi/tagbar.git "${BUNDLE_ROOT}/tagbar"
    fi

    if [ ! -d "${BUNDLE_ROOT}/goyo" ]; then
        git clone git://github.com/junegunn/goyo.vim.git "${BUNDLE_ROOT}/goyo"
    fi

    if [ ! -d "${BUNDLE_ROOT}/vim-commentary" ]; then
        git clone git://github.com/tpope/vim-commentary.git "${BUNDLE_ROOT}/vim-commentary"
    fi

    # Fuzzy Finder for Vim (FZF), requires FZF Github repo to
    # be checked out in ~/.fzf and ~/.fzf/install.sh being run beforehand.
    if [ ! -d "${BUNDLE_ROOT}/fzf" ]; then
        git clone git://github.com/junegunn/fzf.vim "${BUNDLE_ROOT}/fzf"
    fi

    if [ ! -d "${BUNDLE_ROOT}/vim-go" ]; then
        git clone git://github.com/fatih/vim-go.git "${BUNDLE_ROOT}/vim-go"
    fi

    if [ ! -d "${BUNDLE_ROOT}/nerdtree" ]; then
        git clone git://github.com/scrooloose/nerdtree "${BUNDLE_ROOT}/nerdtree"
    fi

    if [ ! -d "${BUNDLE_ROOT}/vim-gitgutter" ]; then
        git clone git://github.com/airblade/vim-gitgutter.git "${BUNDLE_ROOT}/vim-gitgutter"
    fi

    if [ ! -d "${BUNDLE_ROOT}/vim-colors-solarized" ]; then
        git clone git://github.com/altercation/vim-colors-solarized "${BUNDLE_ROOT}/vim-colors-solarized"
    fi

    if [ ! -d "${BUNDLE_ROOT}/syntastic" ]; then
        git clone --depth=1 git://github.com/vim-syntastic/syntastic.git "${BUNDLE_ROOT}/syntastic"
    fi

    if [ ! -d "${BUNDLE_ROOT}/supertab" ]; then
        git clone git://github.com/ervandew/supertab.git "${BUNDLE_ROOT}/supertab"
    fi

    if [ ! -d "${BUNDLE_ROOT}/porter" ]; then
        git clone git://github.com/rkk/porter.git "${BUNDLE_ROOT}/porter"
    fi

    if [ ! -d "${BUNDLE_ROOT}/vim-minisnip" ]; then
        git clone git://github.com/eemed/vim-minisnip "${BUNDLE_ROOT}/vim-minisnip"
    fi
}

# Set up XDG (XDG_CONFIG_HOME).
function setup_xdg {
    if [ "x$XDG_CONFIG_HOME" = "x" ]; then
        XDG_CONFIG_HOME="${HOME}/.config"
    fi
    if [ ! -d "${XDG_CONFIG_HOME}" ]; then
        mkdir -p "${XDG_CONFIG_HOME}"
    fi
    export XDG_CONFIG_HOME
}

# Set up Zathura as default PDF reader.
function setup_zathura {
	xdg-mime default zathura.desktop application/pdf
}

# Set up Plan9port.
function setup_plan9port {
    plan9port_root="/usr/local/plan9"
    if [ ! -d "${plan9port_root}" ]; then
        return
    fi
    if [ -f "${plan9port_root}/bin/acme" ]; then
        return
    fi
    start_dir="$(pwd)"
    cd "${plan9port_root}" && ./INSTALL
    cd "${start_dir}" || return
    go get github.com/davidrjenni/A
}

# Set up i3.
function setup_i3 {
    pip3 install i3ipc
}

# Set up Docker for non-root users on Linux.
function setup_docker_linux {
	sudo usermod -aG docker "$(whoami)"
	sudo newgrp docker
}

# Set up the default time zone on Linux
function setup_timezone_linux {
    echo "Europe/Copenhagen" | sudo tee /etc/timezone
}

# Ensure sudo access on Linux, without using sudo.
function setup_sudo_linux {
    this_user="$(whoami)"
    su - root -c "usermod -aG sudo ${this_user} && newgrp sudo"
}

#
# MAIN
#

os=$(uname)

case "${os}" in
    "Linux")
        setup_xdg
        setup_sudo_linux
        install_linux
        ;;
    "OpenBSD")
        setup_xdg
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

