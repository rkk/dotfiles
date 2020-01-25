set -o vi

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000


EDITOR="vim"
VISUAL="${EDITOR}"
TMPDIR="${HOME}/tmp"
PS1="\$(teleprompt)"
PS2=">> "
PS3=">>> "
PS4=">>>> "
export EDITOR VISUAL TMPDIR PS1 PS2 PS3 PS4

GOROOT="/usr/local/go"
GOPATH="${HOME}/Go"
export GOROOT GOPATH

PATH="${PATH}:${HOME}/bin:${HOME}/.local/bin:/usr/local/go/bin:${GOPATH}/bin"
export PATH

if [ -z ${DISPLAY+x} ]; then
    export DISPLAY=":0"
fi

alias l="ls -1AFo"
alias la="ls -lAh"
alias ltr="ls -latr"
alias a="clear"
alias c="cd"
alias mp="mkdir -p"
alias p="pwd"
alias g="git"
alias gtt="git status"
alias grr="git remote -v show"
alias gll="git log --name-only"
alias gb="git branch"
alias gba="git branch -a"
alias gnew="git checkout -b"
alias gfa="git fetch --all"

secrets="${HOME}/Frameworks/Secrets/secrets.sh"

if [ -f "${secrets}" ]; then
    # shellcheck source=/dev/null
    source "${secrets}"
fi

