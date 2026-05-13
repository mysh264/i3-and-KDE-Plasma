#!/bin/bash

CLASS_TARGET=$1
TYPE_TARGET=$2
NAME_TARGET=$3 # Optional third parameter

# 1. Get all window IDs matching the class name
IDS=$(xdotool search --class "$CLASS_TARGET")

for WID in $IDS; do
    # 2. Check the window type property
    ACTUAL_TYPE=$(xprop -id "$WID" _NET_WM_WINDOW_TYPE 2>/dev/null)

    if [[ "$ACTUAL_TYPE" == *"$TYPE_TARGET"* ]]; then

        # 3. Handle the optional Name Target
        if [[ -n "$NAME_TARGET" ]]; then
            # If a name was provided, only echo if it matches
            ACTUAL_NAME=$(xdotool getwindowname "$WID" 2>/dev/null)

            if [[ "$ACTUAL_NAME" == *"$NAME_TARGET"* ]]; then
                echo "$WID"
            fi
        else
            # If no name was provided, echo the ID based only on Class and Type
            echo "$WID"
        fi
    fi
done
