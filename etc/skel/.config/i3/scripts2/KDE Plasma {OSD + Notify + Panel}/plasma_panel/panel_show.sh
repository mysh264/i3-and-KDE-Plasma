#!/bin/bash
set -x
ID=$(xdotool search --name "Togglehidepanelplasma" | head -n 1)
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
