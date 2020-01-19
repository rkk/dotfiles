#!/bin/sh
if [ -f "${HOME}/bin/setdvorarkk" ]; then
    setxkbmap -option caps:ctrl_modifier
    "${HOME}"/bin/setdvorarkk
fi

xsetroot -solid '#002b36'
xset -b

if [ -f ~/.Xdefaults ]; then
  /usr/bin/xrdb ~/.Xdefaults
fi

# shellcheck disable=SC2046
if [ $(uname -s) = "OpenBSD" ]; then
  /usr/local/bin/i3
fi
