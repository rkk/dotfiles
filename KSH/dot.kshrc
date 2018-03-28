##
## Configuration file for Korn Shell.
##

## Vi-compatible key bindings.
set -o vi

HISTSIZE="2048"
HISTFILE="${HOME}/.history"
export HISTSIZE HISTFILE


##
## ENVIRONMENT
##

EDITOR="vim"
VISUAL="${EDITOR}"
export EDITOR VISUAL

CHARSET="UTF-8"
LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export CHARSET LANG LC_ALL

TMPDIR="${HOME}/tmp"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_RUNTIME_DIR="${TMPDIR}/runtime"

export TMPDIR XDG_CONFIG_HOME XDG_RUNTIME_DIR

if [ ! -d "${TMPDIR}" ]; then
  mkdir -p "${TMPDIR}"
fi

if [ ! -d "${XDG_CONFIG_HOME}" ]; then
  mkdir -p "${XDG_CONFIG_HOME}"
fi

if [ ! -d "${XDG_RUNTIME_DIR}" ]; then
  mkdir -p "${XDG_RUNTIME_DIR}"
fi

if [ ! -z DISPLAY ]; then
  DISPLAY=":0"
  export DISPLAY
fi

## OpenBSD fixes.
if [ "$(uname)" = "OpenBSD" ]; then
    TERM="xterm"
    export TERM
fi


##
## PATHS
##
case `uname -s` in
  'Darwin')
    PATH="/usr/local/bin:$PATH"
    PATH="${PATH}:${HOME}/bin"
    ## Gems for Ruby 1.9 are in the Brew Ruby directory
    PATH="${PATH}:/usr/local/Cellar/ruby/2.0.0-p247/bin"
  ;;
  'Linux')
  PATH="${PATH}:/usr/local/go/bin:~/bin"
  ;;
  'OpenBSD')
  PATH="${PATH}:${HOME}/bin"
  ;;
esac

export PATH


##
## ALIAS
##

alias l="ls -1AFo"
alias la="ls -lAh"
alias ltr="ls -latr"
alias a="clear"
alias c="cd"
alias mp="mkdir -p"
alias g="git"
alias p="pwd"
alias dk="docker"
alias doco="docker-compose"
alias ig="grep -i"
alias v="${EDITOR}"
alias vi="${EDITOR}"
alias view="${EDITOR}"
alias gtt="git status"
alias grr="git remote -v show"
alias gll="git log --name-only"
alias gba="git branch -a"
alias gnew="git checkout -b"
alias gfa="git fetch --all"


##
## PROMPT
##

git_status() {
    delta="$(git ls-files -m 2> /dev/null)"
    if [ "${delta}" = "" ]; then
        exit
    fi
    print " (!)"
}

git_branch() {
    name="$(git branch --no-color 2> /dev/null | grep '^\*' | awk '{print $2}')"
    if [ "${name}" = "" ]; then
        exit
    fi
    print ${name}
}

exit_code() {
    if [ "${?}" -eq 0 ]; then
        exit
    fi
    print "(!)"
}


PS1="\$(tput setaf 2)::\$(tput sgr0)\$(exit_code) \$(git_branch)\$(git_status) \$(basename \${PWD})\$(tput sgr0)# "
PS2=">> "
PS3=">>> "
PS4=">>>> "
export PS1 PS2 PS3 PS4


##
## GO SUPPORT
##

GOROOT="/usr/local/go"
if [ -d ${GOROOT} ]; then
  export GOROOT="${GOROOT}"
  export PATH="${PATH}:${GOROOT}/bin"
fi

GOPATH="${HOME}/Go"
if [ ! -d ${GOPATH} ]; then
  mkdir -p ${GOPATH}/bin
fi
export GOPATH

PATH="${PATH}:${GOPATH}/bin"
export PATH
