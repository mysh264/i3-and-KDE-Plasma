#!/bin/bash
set -x
DIR="$HOME/.config/i3/scripts2/'KDE Plasma {OSD + Notify + Panel}/plasma_panel'"

ID=$(xdotool search --name "Togglehidepanelplasma" | head -n 1)
[ -z "$ID" ] && exit 1

# If it is currently a MENU (Ghost), turn it into a DOCK
if xprop -id "$ID" _NET_WM_WINDOW_TYPE | grep -q "_NET_WM_WINDOW_TYPE_MENU"; then
    # --- GOING TO DOCK MODE ---
    # 1. Turn off override (Let i3 manage it)
    xdotool set_window --overrideredirect 0 "$ID"

    # 2. Set Type to DOCK and add Struts (55px)
    xprop -id "$ID" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DOCK
    xprop -id "$ID" -f _NET_WM_STRUT 32c -set _NET_WM_STRUT "0, 0, 55, 0"

    # 3. Restore standard protocols so i3 recognizes it
    xprop -id "$ID" -f WM_PROTOCOLS 32a -set WM_PROTOCOLS "WM_DELETE_WINDOW, WM_TAKE_FOCUS, _NET_WM_PING"

    # 4. Refresh i3 to recalculate gaps
    xdotool windowmap "$ID"
    i3-msg restart
else
    # --- GOING BACK TO GHOST MODE ---
    bash $HOME/.config/i3/scripts2/'KDE Plasma {OSD + Notify + Panel}/plasma_panel'/panel_show.sh
    i3-msg restart
fi
