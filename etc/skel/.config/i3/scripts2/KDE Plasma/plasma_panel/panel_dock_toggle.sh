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
    # 1. Apply Ghost Properties (No space reservation)
    xprop -id "$ID" -remove _NET_WM_STRUT
    xprop -id "$ID" -remove _NET_WM_STRUT_PARTIAL
    xprop -id "$ID" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_MENU

    # 2. Set Override Redirect (Unmanaged by i3)
    xdotool set_window --overrideredirect 1 "$ID"

    # 3. Position and Map
    xdotool windowmove "$ID" 0 0
    xdotool windowunmap "$ID"
    xdotool windowraise "$ID"
    i3-msg restart
fi


# Signal i3blocks to update
pkill -RTMIN+2 i3blocks
