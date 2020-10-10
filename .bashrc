setup_env() {
	HISTCONTROL=ignoreboth
	shopt -s histappend
	HISTSIZE=1000
	HISTFILESIZE=2000
	set -o vi
	export HISTCONTROL HISTSIZE HISTFILESIZE

	EDITOR="vim"
	VISUAL="${EDITOR}"
	TERMINAL="sakura"
	BROWSER="firefox"
	TMPDIR="${HOME}/tmp"
	export EDITOR VISUAL TERMINAL BROWSER TMPDIR

	PATH="${PATH}:${HOME}/bin:${HOME}/.local/bin"
	export PATH
}


setup_prompt() {
	PS1="% "
	PS2="%% "
	PS3="%%% "
	PS4="%%%% "
	export PS1 PS2 PS3 PS4
}


setup_go() {
	GOROOT="/usr/local/go"
	GOPATH="${HOME}/go"
	PATH="${PATH}:${GOPATH}/bin"
	export GOROOT GOPATH PATH
}


setup_plan9() {
	PLAN9="/usr/local/plan9"
	PATH="${PATH}:${PLAN9}/bin"
	export PLAN9 PATH
}


setup_alias() {
	alias l="/usr/bin/ls -1AFo"
	alias la="/usr/bin/ls -lAh"
	alias la="/usr/bin/ls -latr"
	alias a="clear"
	alias c="cd"
	alias mp="mkdir -p"
	alias d="pwd"
	# Git aliases are handled in ~/.gitconfig.
	alias g="git"
	alias gnew="git checkout -b"
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
