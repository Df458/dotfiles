#!/bin/zsh
#
#
# ~/.xinitrc
#

exec xrdb ~/.Xresources &
#exec xbindkeys &
exec setxkbmap -option caps:swapescape &
exec st -e tmux -2 attach -t main &
#exec xrandr --output VGA-0 --mode 1280x1024 --output LVDS-0 --mode 1600x900 --below VGA-0 &
#exec xrandr --output LVDS-0 --mode 1600x900 --output VGA-0 --mode 1280x1024 --above LVDS-0&
#exec xrandr --output VGA-0 --auto --above LVDS-0
exec dunst &
exec feh --bg-fill ~/Pictures/backgrounds/desktop_background &
exec $WM
