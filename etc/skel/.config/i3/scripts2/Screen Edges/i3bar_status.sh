#!/bin/bash

# Fetch the bar configuration for bar-0
# We use jq to specifically look at the "mode" property
MODE=$(i3-msg -t get_bar_config bar-0 | jq -r '.mode')

if [[ "$MODE" == "dock" ]]; then
    # If the bar is already in dock mode, do nothing to prevent flickering
    exit 0
else
    # If the bar is in 'hide' or 'invisible' mode, toggle the hidden_state
    i3-msg bar hidden_state toggle
fi
