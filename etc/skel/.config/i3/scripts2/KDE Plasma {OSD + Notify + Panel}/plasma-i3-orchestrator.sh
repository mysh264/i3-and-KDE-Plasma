#!/bin/bash
set -x
# Listen for new window events
i3-msg -t subscribe -m '["window"]' | while read -r line; do
    # Extract event details
    EVENT=$(echo "$line" | jq -r '.change')
    CLASS=$(echo "$line" | jq -r '.container.window_properties.class')
    WID=$(echo "$line" | jq -r '.container.window')

    # Only care about new plasmashell windows
    if [[ "$EVENT" == "new" && "$CLASS" == "plasmashell" ]]; then

        # Get the window type
        WINDOW_TYPE=$(xprop -id "$WID" _NET_WM_WINDOW_TYPE)
        name="Togglehidepanelplasma"

        # --- THE PANEL LOGIC ---
        if echo "$WINDOW_TYPE" | grep -q "_NET_WM_WINDOW_TYPE_DOCK"; then
            # Rename if not already named
            if ! xwininfo -id "$WID" | grep -q "$name"; then
                xdotool set_window --name "$name" "$WID"

                # Apply the ghost fix immediately so it doesn't take up space on boot
                # We use a short sleep to ensure KDE is ready for the xprop change
                (sleep 1 && bash $HOME/.config/i3/scripts2/'KDE Plasma {OSD + Notify + Panel}'/plasma_panel/panel_hide.sh) &
            fi

        # --- THE OSD LOGIC (Volume/Brightness) ---
        elif echo "$WINDOW_TYPE" | grep -q "_KDE_NET_WM_WINDOW_TYPE_ON_SCREEN_DISPLAY"; then
            i3-msg "[id=$WID] floating enable, border none, move position center, move down 400px, sticky enable"

        # --- THE NOTIFICATION LOGIC ---
        # Catching both Critical and Standard notifications
        elif echo "$WINDOW_TYPE" | grep -E -q "(_KDE_NET_WM_WINDOW_TYPE_CRITICAL_NOTIFICATION|_NET_WM_WINDOW_TYPE_NOTIFICATION)"; then
            i3-msg "[id=$WID] floating enable, border none, move position 1450 px 45 px, sticky enable"
        fi
    fi
done
