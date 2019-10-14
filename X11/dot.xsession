#!/bin/sh
if [ -f "${HOME}/bin/setdvorarkk" ]; then
    setxkbmap -option caps:ctrl_modifier
    "${HOME}"/bin/setdvorarkk
fi

xsetroot -solid '#002b36'

if [ -f ~/.Xdefaults ]; then
  /usr/bin/xrdb ~/.Xdefaults
fi

if [ $(uname -s) = "OpenBSD" ]; then
  /usr/local/bin/i3
fi

if [ $(uname -s) = "Linux" ]; then
  /usr/bin/i3
fi
