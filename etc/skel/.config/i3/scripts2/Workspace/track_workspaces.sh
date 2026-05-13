#!/bin/bash
LOG_FILE="/tmp/i3_ws_log"

# Initialize: Get current workspace and set it as both Current and Previous
curr=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
prev=$curr

# Write the initial state
printf "%s\n%s\n" "$curr" "$prev" > "$LOG_FILE"

# Listen for ANY workspace change
i3-msg -t subscribe -m '["workspace"]' | while read -r _; do
    # Get the ACTUAL focused workspace name right now
    new=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

    # If the workspace name has changed
    if [[ "$new" != "$curr" ]]; then
        prev=$curr
        curr=$new

        # Write Line 1: Current, Line 2: Previous
        printf "%s\n%s\n" "$curr" "$prev" > "$LOG_FILE"

        # Signal i3blocks to update
        pkill -RTMIN+1 i3blocks
    fi
done
