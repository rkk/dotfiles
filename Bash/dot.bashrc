# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#
# BEHAVIOR
#

set -o vi

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000


#
# ENVIRONMENT
#

EDITOR="vim"
VISUAL="${EDITOR}"
TMPDIR="${HOME}/tmp"
PS1="# "
PS2=">> "
PS3=">>> "
PS4=">>>> "
if [ ! -z DISPLAY ]; then
    DISPLAY=":0.0"
fi
export EDITOR VISUAL TMPDIR PS1 PS2 PS3 PS4 DISPLAY

GOROOT="/usr/local/go"
GOPATH="${HOME}/Go"
export GOROOT GOPATH

case `uname -s` in
    'Linux')
        PATH="${PATH}:${GOROOT}/bin:${HOME}/bin"
        ;;
esac
export PATH

# Speed up ls by removing calls to file attributes.
export LS_COLORS='ex=00:su=00:sg=00:ca=00:'

if [ -f "${HOME}/Frameworks/Secrets/secrets.sh" ]; then
    . "${HOME}/Frameworks/Secrets/secrets.sh"
fi


#
# ALIAS
#

alias l="ls -1AFo"
alias la="ls -lAh"
alias ltr="ls -latr"
alias a="clear"
alias c="cd"
alias mp="mkdir -p"
alias p="pwd"
alias ig="grep -i"
alias g="git"
alias t="tmux"
alias v="${EDITOR}"
alias web="w3m -M"
alias pbpaste="xclip -selection clipboard -o"
alias pbcopy="xclip -selection clipboard"

