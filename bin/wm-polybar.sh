#!/bin/bash
#
# Polybar wrapper, automatically running a per-WM configuration.

is_bspwm=$(pgrep bspwm)
is_cwm=$(pgrep openbsd-cwm)
is_i3=$(pgrep i3)

if [ ! "${is_bspwm}" = "" ]; then
	cfg="${HOME}/.config/polybar/bspwm.ini"
	if [ ! -f "${cfg}" ]; then
		echo "ERROR: Configuration file ${cfg} does not exist"
		exit 1
	fi
	killall -q polybar
	polybar bspwm -c "${cfg}" &
	exit 0
fi

if [ ! "${is_cwm}" = "" ]; then
	cfg="${HOME}/.config/polybar/cwm.ini"
	if [ ! -f "${cfg}" ]; then
		echo "ERROR: Configuration file ${cfg} does not exist"
		exit 1
	fi
	killall -q polybar
	polybar cwm -c "${cfg}" &
	exit 0
fi

if [ ! "${is_i3}" = "" ]; then
	cfg="${HOME}/.config/polybar/i3.ini"
	if [ ! -f "${cfg}" ]; then
		echo "ERROR: Configuration file ${cfg} does not exist"
		exit 1
	fi
	killall -q polybar
	polybar i3 -c "${cfg}" &
	exit 0
fi

echo "No supported window manager found, exiting."
exit 1