#!/bin/bash
set -x

plasmashell --replace & disown
sleep 2
~/.config/i3/scripts2/'KDE Plasma'/plasma_panel/panel_dock_toggle.sh


# Signal i3blocks to update
pkill -RTMIN+2 i3blocks
