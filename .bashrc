setup_env() {
	HISTCONTROL="erasedups:ignoreboth"
	HISTSIZE=1000
	HISTFILESIZE=2000
	HISTTIMEFORMAT='%F %T   '
	shopt -s histappend
	set -o vi
	export HISTCONTROL HISTSIZE HISTFILESIZE HISTTIMEFORMAT

	EDITOR="vim"
	VISUAL="${EDITOR}"
	TMPDIR="${TMPDIR:-$HOME/tmp}"
	export EDITOR VISUAL TMPDIR

	PATH="${HOME}/bin:${HOME}/.local/bin:/usr/local/bin:/usr/bin:/bin:/sbin:${PATH}"
	export PATH

    VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
    LIBVIRT_DEFAULT_URI="${VIRSH_DEFAULT_CONNECT_URI}"
    export VIRSH_DEFAULT_CONNECT_URI LIBVIRT_DEFAULT_URI

    FZF_DEFAULT_OPTS="--reverse --color=light"
    export FZF_DEFAULT_OPTS
    # shellcheck disable=SC1090
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
}


setup_prompt() {
    PS1="$(hostname)% "
	PS2="%% "
	PS3="%%% "
	PS4="%%%% "
	export PS1 PS2 PS3 PS4
}


setup_go() {
	GOROOT="/usr/local/go"
	GOPATH="${HOME}/go"
	PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"
	export GOROOT GOPATH PATH
}


setup_plan9() {
	PLAN9="/usr/local/plan9"
	PATH="${PATH}:${PLAN9}/bin"
	export PLAN9 PATH
}


setup_alias() {
	alias l="/bin/ls -1AFo"
	alias la="/bin/ls -lAh"
	alias la="/bin/ls -latr"
	alias a="clear"
	alias c="cd"
	alias mp="mkdir -p"
    alias h="history | grep"
	alias d="pwd"
	alias g="git"
    alias b="bspc query"
    alias mc="mc --nocolor"
    alias tf="terraform"
    alias vs="virsh"
}


setup_secrets() {
	secrets="${HOME}/Frameworks/Secrets/secrets.sh"

	if [ -f "${secrets}" ]; then
    	# shellcheck source=/dev/null
    	source "${secrets}"
	fi
}


setup_env
setup_prompt
setup_alias

setup_secrets
setup_go
setup_plan9

