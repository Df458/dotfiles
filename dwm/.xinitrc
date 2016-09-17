#!/bin/zsh
#
#
# ~/.xinitrc
#

export DF_X_SESSION=1
export DF_WAYLAND_SESSION=0
exec seasonal_prep &
exec setxkbmap -option caps:swapescape &
exec st -c media-term -e mux media &
exec st -c mail-term  -e mux comms &
exec xrandr --output DVI-1 --mode 1920x1080 --primary --output DVI-0 --mode 1280x1024 --right-of DVI-1 &
exec randbak &
exec dunst &
exec compton &
# exec bardata &
exec $WM
