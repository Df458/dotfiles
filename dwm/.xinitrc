#!/bin/zsh
#
#
# ~/.xinitrc
#

exec xrdb ~/.Xresources &
#exec xbindkeys &
exec setxkbmap -option caps:swapescape &
exec st -c media-term -e mux media &
exec st -c mail-term  -e mux comms &
#exec xrandr --output VGA-0 --mode 1280x1024 --output LVDS-0 --mode 1600x900 --below VGA-0 &
#exec xrandr --output LVDS-0 --mode 1600x900 --output VGA-0 --mode 1280x1024 --above LVDS-0&
#exec xrandr --output VGA-0 --auto --above LVDS-0
#exec xrandr --output DVI-0 --mode 1280x1024 --output DVI-1 --mode 1920x1080 --left-of DVI-0 &
exec xrandr --output DVI-1 --mode 1920x1080 --primary --output DVI-0 --mode 1280x1024 --right-of DVI-1 &
#exec xrandr --output LVDS-0 --mode 1600x900 --output VGA-0 --mode 1920x1080 --left-of LVDS-0 &
#feh --bg-fill ~/Pictures/backgrounds/desktop_background
exec randbak &
exec dunst &
exec compton &
exec bardata &
exec $WM
