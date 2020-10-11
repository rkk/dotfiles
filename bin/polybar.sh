#!/bin/bash
killall -q polybar

polybar bspwm -c "${HOME}/.config/polybar/bspwm.ini"
