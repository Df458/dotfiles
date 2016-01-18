#!/bin/zsh
#
#
# ~/.xinitrc
#

exec xrdb ~/.Xresources &
exec setxkbmap -option caps:swapescape &
exec st -c media-term -e mux media &
exec st -c mail-term  -e mux comms &
exec xrandr --output DVI-1 --mode 1920x1080 --primary --output DVI-0 --mode 1280x1024 --left-of DVI-1 &
exec randbak &
exec dunst &
exec compton &
exec bardata &
exec dwm
