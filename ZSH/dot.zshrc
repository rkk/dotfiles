##
## THEME
##

#ZSH_THEME="80pct"
ZSH_THEME="agnoster"

autoload -U colors && colors
#PROMPT="%t %{$fg[cyan]%}%?%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} %# "
#PROMPT="%{%}%{%}%T%{%}%{%}%{%} %c$(git_prompt_info) %{%} %{%}"

## Slightly better ls colors
LSCOLORS=CxFxExDxBxegedabagacad


##
## PATH
##
case `uname -s` in
  'Darwin')
    ## Add MAMP MySQL in front, to avoid clashes with MacPorts MySQL
    PATH="/Applications/MAMP/Library/bin:${PATH}"
    PATH="${PATH}:~/bin:/opt/local/bin"
    PATH="${PATH}:/usr/local/git/bin"
    PATH="${PATH}:/usr/local/tranquil/bin"
  ;;
  'Linux')
  PATH="${PATH}:~/bin"
  ;;
esac

export PATH


## Enable VI keybindings (Escape still switches mode)
set -o vi
bindkey -v


##
## ALIASES
##
alias c="cd"
alias d="drush"
alias p="pwd"
alias e="~/bin/mvim"
alias l='ls -CF'
alias ls="ls -FG"
alias ll="ls -lFG"
alias la='ls -lAh'
alias ltr="ls -ltrFG"
alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias v="vagrant"
alias igrep="grep -i"
alias ig="grep -i"
alias Grep="grep"
alias vtt="vagrant status"
alias pong="say 'Done'"

## Drush and Drupal
alias drc="drush cc all"
alias dww="drush watchdog-show --tail --sleep-delay=1"
alias d="drush"
alias ddd="drush dd"

## Testing
alias ccp="/Applications/MAMP/bin/php5.3/bin/php /Users/rkk/Frameworks/codecept/codecept.phar"

## Git
alias g="git"
alias gtt="git status"
alias gll="git log --name-only"
alias gba="git branch -a"
alias gbb="git branch"
alias gnn="git diff --name-only"
alias gcon="git branch --contains"


##
## BEHAVIOR
##

## Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

## Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

## Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

## Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

## Disable auto-correct (correct_all in older versions of Zsh)
unsetopt correct
unsetopt correct_all

## Local and environment, enable non-ASCII chars in Git log and such
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##
## PLUGINS
##

case `uname -s` in
    'Darwin')
    plugins=(git vagrant vundle osx capistrano)
    ;;
esac


##
## OH MY ZSH
##

ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="rkk"

[[ -d $ZSH ]] && source $ZSH/oh-my-zsh.sh


##
## TMUXINATOR
##

tmuxinator="$HOME/.tmuxinator/scripts/tmuxinator"
[[ -s $tmuxinator ]] && source $tmuxinator

