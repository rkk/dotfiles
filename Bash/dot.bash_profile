##
## PATH
##

## Ant, put in front to avoid using built-in buggy Ant-1.7.1
PATH="~/Frameworks/Ant/bin:${PATH}"

## Drush, link in ~/bin to ~/Frameworks/drush
PATH="${PATH}:${HOME}/bin"

## Git
PATH="${PATH}:/usr/local/git/bin"

## MacPorts
PATH="/opt/local/bin:/opt/local/sbin:${PATH}"

## Set the path
export PATH


##
## HISTORY
##

export HISTSIZE=100000
## Don't put duplicate lines in the history. See bash(1) for more options
## Don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

## Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


##
## PROMPT
##

PS1="\[\e[0;30;47m\]\u@\h\[\e[0m\]:\W$ "
export PS1


##
## COLORS
##

## Directories are green, not blue
LSCOLORS="DxgxcxdxCxegedabagacad"
export LSCOLORS


##
## ALIASES
##

alias c="cd"
alias p="pwd"
alias e="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n"
alias l='ls -CF'
alias ls="ls -FG"
alias ll="ls -lFG"
alias la='ls -lAh'
alias ltr="ls -ltrFG"

## Git
alias gtt="git status"
alias gll="git log"
alias gba="git branch -a"
alias gbb="git branch"
alias gmm="git diff | mate"
alias gnn="git diff --name-only"


##
## MISC
##

EDITOR="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
export EDITOR


##
## ANT
##

ANT_HOME="${ANT_HOME}:~/Frameworks/Ant"
export ANT_HOME


##
## PYTHON
##

PYTHONPATH="${PYTHONPATH}:~/Frameworks/PhidgetsPython/Phidgets"
export PYTHONPATH


