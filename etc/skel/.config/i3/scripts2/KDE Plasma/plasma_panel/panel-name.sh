#!/bin/bash
set -x
CLASS_TARGET="plasmashell"
TYPE_TARGET="_NET_WM_WINDOW_TYPE_DOCK"
TYPE_TARGET_GHOST="_NET_WM_WINDOW_TYPE_MENU"

# 1. Get all window IDs matching the class name
# --class ignores window titles and names
IDS=$(xdotool search --class "$CLASS_TARGET")

for WID in $IDS; do
    # 2. Check the window type property for each ID
    # We look for the ATOM value assigned to _NET_WM_WINDOW_TYPE
    ACTUAL_TYPE=$(xprop -id "$WID" _NET_WM_WINDOW_TYPE 2>/dev/null)

    if [[ "$ACTUAL_TYPE" == *"$TYPE_TARGET"* ]] || [[ "$ACTUAL_TYPE" == *"$TYPE_TARGET_GHOST"* ]]; then
        echo "$WID"
    fi
done

# 2, Give Plasma Panel a Unique Name

name="Togglehidepanelplasma"

# --- THE PANEL LOGIC ---

# Rename if not already named
if ! xprop -id "$WID" WM_NAME | grep -q "$name"; then
    xdotool set_window --name "$name" "$WID"

#    # 3. Go to Ghost MODE
#    elif xprop -id "$WID" _NET_WM_WINDOW_TYPE | grep -q "_NET_WM_WINDOW_TYPE_DOCK"; then
#    bash $HOME/.config/i3/scripts2/'KDE Plasma'/plasma_panel/panel_ghost_mode.sh &

fi
