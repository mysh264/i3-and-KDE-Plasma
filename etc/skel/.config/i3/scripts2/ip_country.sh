#!/bin/bash

# Fetch IP and Geolocation data (timeout after 5 seconds)
RESPONSE=$(curl -s -m 5 https://ipwho.is/)

# Check if the connection failed
if [ -z "$RESPONSE" ]; then
    echo "❌ Offline"      # Full text
    echo "❌"              # Short text
    echo "#FF5555"         # Output color (Red) for error
    exit 0
fi

# Extract data using jq
IP=$(echo "$RESPONSE" | jq -r '.ip')
FLAG=$(echo "$RESPONSE" | jq -r '.flag.emoji')
COUNTRY=$(echo "$RESPONSE" | jq -r '.country_code') # Use '.country' for full name

# i3blocks expects up to 3 lines of output:
# Line 1: Full text
# Line 2: Short text
# Line 3: Color (Optional, overrides the config file color)

# echo "$FLAG $IP ($COUNTRY)"
# echo "$FLAG $IP"

echo "$FLAG"
# Note: We don't echo a color here so it defaults to the color in your i3blocks.conf
