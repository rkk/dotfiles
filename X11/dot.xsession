#!/bin/bash
if [ -f "${HOME}/bin/setdvorarkk" ]; then
    setxkbmap -option caps:ctrl_modifier
    "${HOME}"/bin/setdvorarkk
fi

xsetroot -solid '#002b36'

if [ -f ~/.Xdefaults ]; then
  /usr/bin/xrdb ~/.Xdefaults
fi

if [ -f /usr/bin/xfce4-volumed ]; then
  /usr/bin/xfce4-volumed
fi

if [ -f /usr/bin/redshift ]; then
  /usr/bin/redshift -l 55.676098:12.568 &
fi

if [ $(uname -s) = "OpenBSD" ]; then
  /usr/local/bin/i3
fi
