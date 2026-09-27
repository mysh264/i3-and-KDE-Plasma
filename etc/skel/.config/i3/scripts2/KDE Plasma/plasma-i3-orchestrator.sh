#!/bin/bash

# Notification box width (px) and distance from the right/top screen edges
NOTIF_WIDTH=370
NOTIF_MARGIN_RIGHT=100
NOTIF_MARGIN_TOP=100

# Listen for new window events
i3-msg -t subscribe -m '["window"]' | while read -r line; do
    # Check if the event is a "new" window and if the class is plasmashell
    EVENT=$(echo "$line" | jq -r '.change')
    CLASS=$(echo "$line" | jq -r '.container.window_properties.class')
    WID=$(echo "$line" | jq -r '.container.window')

    if [[ "$EVENT" == "new" && "$CLASS" == "plasmashell" ]]; then
        # Check the specific KDE atoms from your xprop data
        WINDOW_TYPE=$(xprop -id "$WID" _NET_WM_WINDOW_TYPE)

        if echo "$WINDOW_TYPE" | grep -q "_KDE_NET_WM_WINDOW_TYPE_ON_SCREEN_DISPLAY"; then
            # Move OSD to bottom center
            i3-msg "[id=$WID] floating enable, border none, move position center, move down 400px, sticky enable"

        elif echo "$WINDOW_TYPE" | grep -q "_KDE_NET_WM_WINDOW_TYPE_CRITICAL_NOTIFICATION"; then
            # Move Notification to top right (computed from the current screen width)
            SCREEN_W=$(xdpyinfo | awk '/dimensions/ {split($2, d, "x"); print d[1]}')
            X=$(( ${SCREEN_W:-1920} - NOTIF_WIDTH - NOTIF_MARGIN_RIGHT ))
            i3-msg "[id=$WID] floating enable, border none, move position $X px $NOTIF_MARGIN_TOP px, sticky enable"
        fi
    fi
done
