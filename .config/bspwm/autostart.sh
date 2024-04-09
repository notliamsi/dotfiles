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
redshift -x
redshift -l 40.4165:-3.70256 &
nitrogen --restore &
killall dunst
dunst &
$HOME/.config/polybar/launch.sh &
killall playerctld
playerctld daemon &
$HOME/.local/bin/yarr &
$HOME/.local/bin/ram-monitor &
killall megasync
megasync &
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1 || xinput set-prop "Synaptics TM2722-001" "libinput Tapping Enabled" 1 || notify-send -u critical "Touchpad Name Not Found"
killall com.gitlab.bitseater.meteo
flatpak run com.gitlab.bitseater.meteo &
killall xfce4-power-manager
xfce4-power-manager &
killall xfce4-clipman
xfce4-clipman &
killall org.munadi.Munadi
flatpak run org.munadi.Munadi &

