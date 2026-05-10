#!/bin/bash

i3-msg -t get_bar_config bar-0 | while read -r line; do
    MODE=$(echo "$line" | grep -o dock)

    if [[ "$MODE" == "dock" ]]; then
    echo "Nothing to do"
    else
    i3-msg bar hidden_state toggle
    fi
done
