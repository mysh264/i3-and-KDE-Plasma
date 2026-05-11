#!/bin/bash

# --- CONFIGURATION: Add your script paths here ---
# Tip: Use absolute paths to avoid any "file not found" issues.
SCRIPTS=(
    "$HOME/.config/i3/scripts2/Screen Edges/master_perimeter_control.sh"
    "$HOME/.config/i3/scripts2/KDE Plasma {OSD + Notify + Panel}/plasma-i3-orchestrator.sh"
    # "/path/to/your/third_script.sh"
    # "/path/to/your/fourth_script.sh"
    # "/path/to/your/fifth_script.sh"
    # "/path/to/your/sixth_script.sh"
)

echo "--- Perimeter Manager: Restarting Stack ---"

for SCRIPT_PATH in "${SCRIPTS[@]}"; do
    if [[ -f "$SCRIPT_PATH" ]]; then
        SCRIPT_NAME=$(basename "$SCRIPT_PATH")

        # 1. Kill the old process.
        # We use [char] trick for pkill so the manager doesn't kill itself
        # if its own path happens to contain one of these names.
        FIRST_CHAR="${SCRIPT_NAME:0:1}"
        REST="${SCRIPT_NAME:1}"
        PATTERN="[$FIRST_CHAR]$REST"

        echo "Stopping: $SCRIPT_NAME"
        pkill -f "$PATTERN" && sleep 0.2

        # 2. Launch the new process in the background
        echo "Starting: $SCRIPT_NAME"
        bash "$SCRIPT_PATH" &
    else
        echo "Warning: Script not found at $SCRIPT_PATH"
    fi
done

echo "--- All scripts processed ---"
