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


xdotool windowunmap "$ID"


# Signal i3blocks to update
pkill -RTMIN+2 i3blocks
