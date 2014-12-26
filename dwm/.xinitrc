#!/bin/zsh
#
#
# ~/.xinitrc
#

exec xbindkeys &
exec setxkbmap -option caps:swapescape &
exec st -e tmux -2 attach -t main &
exec xrandr --output VGA1 --auto --above LVDS1 &
exec feh --bg-scale ~/Pictures/backgrounds/desktop_background &
exec $WM
