#!/bin/bash
#
# Installs the packages and tools that make up the environment.
# The script is designed to be idempotent, so no side effects
# are expected, if run multiple times.

FONT_ROOT="${HOME}/.local/share/fonts"
TMPDIR="${TMPDIR:-/tmp}"

function usage() {
    script="$(basename "${0}")"
	cat << EOF
Usage: ${script} OPTIONS

    --all         Install all profiles
    --only-devel  Install only the development profile
    --only-x11    Install only the X11 profile

Run as the non-root user intended to use the environment.
EOF
}

function ensure_not_sudo() {
    if [ "${EUID}" -eq 0 ]; then
        echo "ERROR: Script run in sudo or as root"
        exit 2
    fi
}

function add_pkg() {
    pkgs="${1}"
    if [ "x${pkgs}" = "x" ]; then
        exit 1
    fi
    sudo apt-get install -y "${@}" --no-install-recommends
}

function init_pkg() {
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        lsb-release \
        --no-install-recommends
}

function clean_up_pkg() {
	sudo apt-get autoremove -y
	sudo apt-get autoclean -y
	sudo apt-get clean -y
}

function install_devel_packages() {
    apt_packages="tmux vim git shellcheck jq exuberant-ctags fzf automake autotools-dev"
    apt_packages="${apt_packages} coreutils gzip zip unzip bzip2 xz-utils"
    apt_packages="${apt_packages} dnsutils whois net-tools"
    apt_packages="${apt_packages} curl w3m mc"
    apt_packages="${apt_packages} python-pip"

    add_pkg "${apt_packages}"
}

function install_x11_packages() {
    apt_packages="i3-wm i3status i3lock xautolock dmenu rofi sxhkd xterm rxvt-unicode"
    apt_packages="${apt_packages} sxiv zathura firefox pcmanfm autorandr"
    apt_packages="${apt_packages} redshift polybar xclip autocutsel unclutter"

    add_pkg "${apt_packages}"
}

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

function install_ms_fonts {
    add_pkg "cabextract"
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

function install_go {
    GO_SRC="/usr/local/go"
    if [ ! -d "${GO_SRC}" ]; then
        GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")
        GO_VERSION=${GO_VERSION#go}
        (
            kernel=$(uname -s | tr '[:upper:]' '[:lower:]')
            curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.${kernel}-amd64.tar.gz" | sudo tar -C /usr/local -xz
        )
    fi
}

function install_go_packages() {
    export PATH="${PATH}:/usr/local/go/bin"
    # Keep list in sync with ~/.vim/bundle/vim-go/plugin/go.vim.
    pkgs="golang.org/x/lint/golint golang.org/x/tools/cmd/cover"
    pkgs="${pkgs} golang.org/x/review/git-codereview golang.org/x/tools/cmd/goimports"
    pkgs="${pkgs} golang.org/x/tools/cmd/gorename golang.org/x/tools/cmd/guru"
    pkgs="${pkgs} github.com/jstemmer/gotags github.com/nsf/gocode"
    pkgs="${pkgs} github.com/rogpeppe/godef github.com/klauspost/asmfmt/cmd/asmfmt"
    pkgs="${pkgs} github.com/go-delve/delve/cmd/dlv github.com/kisielk/errcheck"
    pkgs="${pkgs} github.com/davidrjenni/reftools/cmd/fillstruct golang.org/x/tools/gopls"
    pkgs="${pkgs} github.com/golangci/golangci-lint/cmd/golangci-lint"
    pkgs="${pkgs} honnef.co/go/tools/cmd/staticcheck github.com/fatih/gomodifytags"
    pkgs="${pkgs} github.com/josharian/impl honnef.co/go/tools/cmd/keyify"
    pkgs="${pkgs} github.com/fatih/motion github.com/koron/iferr"

    for p in ${pkgs}
    do
        go install "${p}@latest"
    done
}

function install_dvorarkk {
    dvorarkk_dir="${HOME}/.config/dvorarkk"
    if [ ! -d "${dvorarkk_dir}" ]; then
        git clone https://github.com/rkk/Dvorarkk.git "${dvorarkk_dir}"
    fi
}

function install_git_aliases {
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

function profile_install_devel {
	init_pkg

	install_devel_packages
	install_go
	install_go_packages
	install_git_aliases

    clean_up_pkg
}

function profile_install_x11 {
	init_pkg

	install_x11_packages
	install_dvorarkk
	install_go_fonts
	install_ms_fonts

    clean_up_pkg
}

function profile_install_all {
	profile_install_devel
	profile_install_x11

}

if [ ${#} -eq 0 ]; then
	usage
	exit 0
fi

ensure_not_sudo

for opt in "${@}"; do
	case ${opt} in
		--all)
		profile_install_all
		echo ""
		echo "Done."
		;;
		--only-devel)
		profile_install_devel
		echo ""
		echo "Done."
		;;
		--only-x11)
		profile_install_x11
		echo ""
		echo "Done."
		;;
		*)
		echo "Unknown option: ${opt}"
		exit 1
		;;
	esac
done

