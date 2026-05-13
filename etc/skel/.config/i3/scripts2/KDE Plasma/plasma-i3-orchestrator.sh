#!/bin/bash

# Listen for new window events
i3-msg -t subscribe -m '["window"]' | while read -r line; do
    # Check if the event is a "new" window and if the class is plasmashell
    EVENT=$(echo "$line" | jq -r '.change')
    CLASS=$(echo "$line" | jq -r '.container.window_properties.class')
    WID=$(echo "$line" | jq -r '.container.window')

    if [[ "$EVENT" == "new" && "$CLASS" == "plasmashell" ]]; then
        # Give Plasma a millisecond to set its internal atoms
        #sleep 0.1

        # Check the specific KDE atoms from your xprop data
        WINDOW_TYPE=$(xprop -id "$WID" _NET_WM_WINDOW_TYPE)

        if echo "$WINDOW_TYPE" | grep -q "_KDE_NET_WM_WINDOW_TYPE_ON_SCREEN_DISPLAY"; then
            # Move OSD to bottom center
            i3-msg "[id=$WID] floating enable, border none, move position center, move down 400px, sticky enable"

        elif echo "$WINDOW_TYPE" | grep -q "_KDE_NET_WM_WINDOW_TYPE_CRITICAL_NOTIFICATION"; then
            # Move Notification to top right
            i3-msg "[id=$WID] floating enable, border none, move position 1450 px 100 px, sticky enable"
        fi
    fi
done
