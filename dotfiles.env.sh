#!/bin/bash
#
# Provides functionality for dotfiles installation. Not designed to
# be executed, but rather sourced from other scripts.
# The functionality is split into separate functions with a dotfiles
# prefix so this script can be sourced from other scripts without risk
# of name conflicts.

FONT_ROOT="${HOME}/.local/share/fonts"
TMPDIR="${TMPDIR:-/tmp}"

function dotfiles_add_pkg() {
    pkgs="${1}"
    if [ "x${pkgs}" = "x" ]; then
        exit 1
    fi
    for p in ${pkgs}
    do
        sudo apt-get install -y "${p}"
        install_res="${?}"
        if [ "${install_res}" -ne 0 ]; then
            echo "ERROR: Cannot install Apt package ${p}"
        fi
    done
}

function dotfiles_install_devel_packages() {
    apt_packages="tmux vim git shellcheck jq exuberant-ctags fzf automake autotools-dev"
    apt_packages="${apt_packages} coreutils gzip zip unzip bzip2 xz-utils"
    apt_packages="${apt_packages} dnsutils whois net-tools"
    apt_packages="${apt_packages} curl w3m mc"
    apt_packages="${apt_packages} python-pip"

    dotfiles_add_pkg "${apt_packages}"
}

function dotfiles_install_x11_packages() {
    apt_packages="i3-wm i3status i3lock xautolock dmenu rofi sxhkd xterm rxvt-unicode"
    apt_packages="${apt_packages} sxiv zathura firefox pcmanfm autorandr"
    apt_packages="${apt_packages} redshift polybar xclip autocutsel unclutter"

    dotfiles_add_pkg "${apt_packages}"
}

function dotfiles_install_go_fonts {
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

function dotfiles_install_ms_fonts {
    dotfiles_apt_install "cabextract"
    if [ ! -d "${FONT_ROOT}" ]; then
        mkdir -p "${FONT_ROOT}"
    fi
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

function dotfiles_install_go {
    GO_SRC="/usr/local/go"
    if [ ! -d "${GO_SRC}" ]; then
        GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")
        GO_VERSION=${GO_VERSION#go}
        (
            kernel=$(uname -s | tr '[:upper:]' '[:lower:]')
            curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.${kernel}-amd64.tar.gz" | sudo tar -v -C /usr/local -xz
        )
    fi
}

function dotfiles_install_go_packages() {
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
}

function dotfiles_install_dvorarkk {
    dvorarkk_dir="${HOME}/.config/dvorarkk"
    if [ ! -d "${dvorarkk_dir}" ]; then
        git clone https://github.com/rkk/Dvorarkk.git "${dvorarkk_dir}"
    fi
}

function dotfiles_install_git_aliases {
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

function dotfiles_linux_install_profile_devel {
	sudo apt-get update
	dotfiles_install_devel_packages
	dotfiles_install_go
	dotfiles_install_go_packages
	dotfiles_install_git_aliases

	sudo apt autoremove
	sudo apt autoclean
	sudo apt clean
}

function dotfiles_linux_install_profile_x11 {
	sudo apt-get update

	dotfiles_install_x11_packages
	dotfiles_install_dvorarkk
	dotfiles_install_go_fonts
	dotfiles_install_ms_fonts

	sudo apt autoremove
	sudo apt autoclean
	sudo apt clean
}

function dotfiles_linux_install_profile_all {
	dotfiles_install_profile_devel
	dotfiles_install_profile_x11

}
