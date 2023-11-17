#!/bin/bash

# Monitor setup
if [[ $(xrandr -q | grep 'VGA-1 connected') ]]; then
	xrandr --output VGA-1 --primary --mode 1680x1050 --rotate normal --output eDP-1 --mode 1366x768 --rotate normal --left-of VGA-1

else
	xrandr --output eDP-1 --primary --mode 1366x768 --rotate normal 
fi


killall sxhkd
sxhkd &
killall redshift
redshift -l 40.4165:-3.70256 &
nitrogen --restore &
killall dunst
dunst &
$HOME/.config/polybar/launch.sh &
killall playerctld
playerctld daemon &
yarr &


