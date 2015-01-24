#!/bin/zsh
#
#
# ~/.xinitrc
#

exec xrdb ~/.Xresources &
exec xbindkeys &
exec setxkbmap -option caps:swapescape &
exec st -e tmux -2 attach -t main &
exec xrandr --output VGA1 --auto --above LVDS1 &
exec feh --bg-fill ~/Pictures/backgrounds/desktop_background &
exec $WM
