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

# 1. Apply Ghost Properties (No space reservation)
xprop -id "$ID" -remove _NET_WM_STRUT
xprop -id "$ID" -remove _NET_WM_STRUT_PARTIAL
xprop -id "$ID" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_MENU

# 2. Set Override Redirect (Unmanaged by i3)
xdotool set_window --overrideredirect 1 "$ID"

# 3. Position and Map
xdotool windowmove "$ID" 0 0
xdotool windowmap "$ID"
xdotool windowraise "$ID"

# Signal i3blocks to update
pkill -RTMIN+2 i3blocks
