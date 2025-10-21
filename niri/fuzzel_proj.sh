#!/bin/sh
base_dir=~/programming
selection=$(ls $base_dir | fuzzel --dmenu)

[ -z "$selection" ] && exit 1

cd $base_dir/$selection
neovide & 
foot &
sleep 0.65
niri msg action consume-or-expel-window-left
