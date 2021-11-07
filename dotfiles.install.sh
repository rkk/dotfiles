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
usage: ${script} OPTIONS

    --all         Install all profiles
    --only-devel  Install only the development profile
    --only-x11    Install only the X11 profile

EOF
}

function add_pkg() {
    pkgs="${1}"
    if [ "x${pkgs}" = "x" ]; then
        exit 1
    fi
    sudo apt-get install -y "${@}" --no-install-recommends
}

function init_pkg() {
    sudo apt update
}

function clean_up_pkg() {
	sudo apt autoremove
	sudo apt autoclean
	sudo apt clean
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
            curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.${kernel}-amd64.tar.gz" | sudo tar -v -C /usr/local -xz
        )
    fi
}

function install_go_packages() {
    export PATH="${PATH}:/usr/local/go/bin"
    # Replace "go get" with go modules.
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

