#!/bin/bash
CLASS_TARGET="plasmashell"
TYPE_TARGET="_NET_WM_WINDOW_TYPE_DOCK"
TYPE_TARGET_GHOST="_NET_WM_WINDOW_TYPE_MENU"

# 1. Find the first plasmashell window that is the panel (Dock or Ghost)
# --class ignores window titles and names
IDS=$(xdotool search --class "$CLASS_TARGET")

WID=""
for ID in $IDS; do
    ACTUAL_TYPE=$(xprop -id "$ID" _NET_WM_WINDOW_TYPE 2>/dev/null)

    if [[ "$ACTUAL_TYPE" == *"$TYPE_TARGET"* ]] || [[ "$ACTUAL_TYPE" == *"$TYPE_TARGET_GHOST"* ]]; then
        WID="$ID"
        break
    fi
done

[ -z "$WID" ] && exit 1

# 2. Give Plasma Panel a Unique Name
name="Togglehidepanelplasma"

# Rename if not already named
if ! xprop -id "$WID" WM_NAME | grep -q "$name"; then
    xdotool set_window --name "$name" "$WID"
fi

echo "$WID"
