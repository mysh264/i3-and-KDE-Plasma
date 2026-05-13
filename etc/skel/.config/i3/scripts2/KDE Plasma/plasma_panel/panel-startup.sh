#!/bin/bash

# --- CONFIGURATION ---
CLASS_TARGET="plasmashell"
TYPE_TARGET="_NET_WM_WINDOW_TYPE_DOCK"
PANEL_NAME="Togglehidepanelplasma"
GHOST_SCRIPT="$HOME/.config/i3/scripts2/KDE Plasma/plasma_panel/panel_ghost_mode.sh"

echo "Waiting for Plasma Panel to initialize..."

# --- THE SEARCH LOOP ---
while true; do
    # 1. Search for all window IDs matching the class
    IDS=$(xdotool search --class "$CLASS_TARGET" 2>/dev/null)

    for WID in $IDS; do
        # 2. Check if this specific ID is the Dock/Panel
        ACTUAL_TYPE=$(xprop -id "$WID" _NET_WM_WINDOW_TYPE 2>/dev/null)

        if [[ "$ACTUAL_TYPE" == *"$TYPE_TARGET"* ]]; then
            echo "Panel found (ID: $WID). Configuring..."

            # 3. Give Plasma Panel the Unique Name
            xdotool set_window --name "$PANEL_NAME" "$WID"

            # 4. Trigger Ghost Mode
            if [[ -f "$GHOST_SCRIPT" ]]; then
                bash "$GHOST_SCRIPT" &
                disown
            else
                echo "Warning: Ghost Mode script not found at $GHOST_SCRIPT"
            fi

            # 5. Success: Exit the entire script
            echo "Configuration complete. Exiting loop."
            exit 0
        fi
    done

    # Wait before trying again to save CPU
    sleep 2
done
