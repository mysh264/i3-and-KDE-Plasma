#!/bin/bash
set -x

ID=$("$HOME/.config/i3/scripts2/KDE Plasma/id.sh" plasmashell _NET_WM_WINDOW_TYPE_DOCK Togglehidepanelplasma)

if [ -z "$ID" ]; then
ID=$("$HOME/.config/i3/scripts2/KDE Plasma/id.sh" plasmashell _NET_WM_WINDOW_TYPE_MENU Togglehidepanelplasma)
fi

if [ -z "$ID" ]; then
$("$HOME/.config/i3/scripts2/KDE Plasma/plasma_panel/panel-name.sh")

ID=$("$HOME/.config/i3/scripts2/KDE Plasma/id.sh" plasmashell _NET_WM_WINDOW_TYPE_DOCK Togglehidepanelplasma)
fi
if [ -z "$ID" ]; then
ID=$("$HOME/.config/i3/scripts2/KDE Plasma/id.sh" plasmashell _NET_WM_WINDOW_TYPE_MENU Togglehidepanelplasma)
fi

[ -z "$ID" ] && exit 1

# xwininfo reply (xorg-xwininfo)
hide=IsUnMapped
unhide=IsViewable

# Get the window type
        WINDOW_TYPE=$(xprop -id "$ID" _NET_WM_WINDOW_TYPE)
        if echo "$WINDOW_TYPE" | grep -q "_NET_WM_WINDOW_TYPE_DOCK"; then
        echo "do nothing"
        exit 1
        fi

# Current panel status
status=$(xwininfo -id "$ID" | grep 'Map State' | awk '{print $3}')

# Toggle the panel

## if the panel is hidden then show it
if [ $status == $hide ] ; then
    bash $HOME/.config/i3/scripts2/'KDE Plasma'/plasma_panel/panel_show.sh
else

## is the panel is not hidden then hide it.
    if [ $status == $unhide ] ; then
        bash $HOME/.config/i3/scripts2/'KDE Plasma'/plasma_panel/panel_hide.sh
        fi

fi

# Signal i3blocks to update
pkill -RTMIN+2 i3blocks
