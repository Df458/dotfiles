#!/bin/zsh
#
#
# ~/.xinitrc
#

export DF_X_SESSION=1
export DF_WAYLAND_SESSION=0
exec seasonal_prep &
exec setxkbmap -option caps:swapescape &
exec xrandr --output DVI-1 --mode 1920x1080 --primary --output DVI-0 --mode 1280x1024 --right-of DVI-1 &
# exec start_terms &
exec randbak &
# exec dunst &
exec compton &
# exec bardata &
# exec sxhkd &
# exec wspace -i &
# exec wspace -g 1 &
exec $WM
# exec herbstluftwm --locked
