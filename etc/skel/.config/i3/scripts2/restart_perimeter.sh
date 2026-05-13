#!/bin/bash

# --- CONFIGURATION ---
SCRIPTS=(
    "$HOME/.config/i3/scripts2/Screen Edges/master_perimeter_control.sh"
    "$HOME/.config/i3/scripts2/KDE Plasma/plasma-i3-orchestrator.sh"
    "$HOME/.config/i3/scripts2/Workspace/track_workspaces.sh"
    # "/path/to/your/fifth_script.sh"
    # "/path/to/your/sixth_script.sh"
)

echo "--- Perimeter Manager: Restarting Stack ---"

for SCRIPT_PATH in "${SCRIPTS[@]}"; do
    if [[ -f "$SCRIPT_PATH" ]]; then
        SCRIPT_NAME=$(basename "$SCRIPT_PATH")

        # 1. Kill the old process using a precise pattern
        # We use a regex to ensure we don't kill this manager script itself
        echo "Stopping: $SCRIPT_NAME"
        pkill -f "/$SCRIPT_NAME"
        sleep 0.2

        # 2. Launch in the background and DISOWN
        # The '&' makes it a background task
        # 'disown' lets the manager exit without killing the child
        echo "Starting: $SCRIPT_NAME"
        bash "$SCRIPT_PATH" > /dev/null 2>&1 &
        disown
    else
        echo "Warning: Script not found at $SCRIPT_PATH"
    fi
done

echo "--- All scripts processed. Manager exiting. ---"
exit 0
