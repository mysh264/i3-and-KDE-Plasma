#!/bin/bash
set - x
DIR="$HOME/.config/i3/scripts2/'KDE Plasma {OSD + Notify + Panel}/plasma_panel'"

# xwininfo reply (xorg-xwininfo)
hide=IsUnMapped
unhide=IsViewable

ID=$(xdotool search --name "Togglehidepanelplasma" | head -n 1)
[ -z "$ID" ] && exit 1

# Current panel status
status=$(xwininfo -id "$ID" | grep 'Map State' | awk '{print $3}')

# Toggle the panel

## if the panel is hidden then show it
if [ $status == $hide ] ; then
    bash $HOME/.config/i3/scripts2/'KDE Plasma {OSD + Notify + Panel}/plasma_panel'/panel_show.sh
else

## is the panel is not hidden then hide it.
    if [ $status == $unhide ] ; then
        bash $HOME/.config/i3/scripts2/'KDE Plasma {OSD + Notify + Panel}/plasma_panel'/panel_hide.sh
        fi

fi
