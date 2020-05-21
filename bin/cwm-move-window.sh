#!/bin/sh
# Move a window to the side of a screen.

case "$1" in
	"left") xdotool getactivewindow windowmove 0 y ;;
	"top")  xdotool getactivewindow windowmove x 0 ;;

	"right")
		screen_width=$(xwininfo -root | grep Width | cut -d: -f2 | tr -d ' ')
		win_width=$(xdotool getactivewindow  getwindowgeometry --shell | grep WIDTH | cut -d= -f2)
		xdotool getactivewindow windowmove $(( $screen_width - $win_width )) y
		;;
	"bottom")
		screen_height=$(xwininfo -root | grep Height | cut -d: -f2 | tr -d ' ')
		win_height=$(xdotool getactivewindow  getwindowgeometry --shell | grep HEIGHT | cut -d= -f2)
		xdotool getactivewindow windowmove x $(( $screen_height - $win_height ))
		;;
	*)
		echo "Unsupported: \"$1\""
		exit 1
esac