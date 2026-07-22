#!/bin/bash

# Configuration
SERVER_IP="100.100.1.4"
USER="mahmoud"
KEY_PATH="$HOME/.ssh/vs2/mahmoud/id_ed25519_mahmoud_vs2"
SOCKET="$HOME/.ssh/sockets/control-${USER}@${SERVER_IP}_22"

# 1. Establish Master Connection
mkdir -p "$HOME/.ssh/sockets"
if ! ssh -O check -S "$SOCKET" dummy_host 2>/dev/null; then
    ssh -i "$KEY_PATH" -M -S "$SOCKET" -fN -o ControlPersist=1h "$USER@$SERVER_IP"
fi

# 2. Pull metrics (Outputting as CSV for easy parsing)
# We calculate CPU remotely and pass the raw data back
DATA=$(ssh -i "$KEY_PATH" -q -o ConnectTimeout=1 -S "$SOCKET" "$USER@$SERVER_IP" "
    # Calculate CPU usage
    CPU_NUM=\$(top -bn2 -d 0.01 | grep 'Cpu(s)' | tail -n 1 | awk '{print 100 - \$8}')
    # Gather other metrics
    RAM=\$(free | awk '/Mem/{printf \"%.0f%%\", (\$3/\$2)*100}')
    DISK_ROOT=\$(df -h / | awk 'NR==2 {print \$4}')
    LOAD=\$(uptime | awk -F'load average:' '{print \$2}' | cut -d, -f1 | xargs)

    # Return as comma-separated values
    echo \"\$CPU_NUM,\$RAM,\$DISK_ROOT,\$LOAD\"
")

# If connection fails
if [ $? -ne 0 ] || [ -z "$DATA" ]; then
    echo "SVR OFFLINE"
    echo "SVR OFFLINE"
    echo "#FF0000"
    exit 0
fi

# 3. Parse variables
CPU_VAL=$(echo "$DATA" | cut -d, -f1)
RAM_VAL=$(echo "$DATA" | cut -d, -f2)
DISK_VAL=$(echo "$DATA" | cut -d, -f3)
LOAD_VAL=$(echo "$DATA" | cut -d, -f4)

# 4. Logic and Formatting
# Nord Theme Palette
#BASE_COLOR="#88C0D0" # Arctic Blue
#ALERT_COLOR="#D08770" # Nord Orange
BASE_COLOR="#00FF41" #(Matrix Green)
ALERT_COLOR="#FF3131" #(Terminal Red)

# Round CPU for color logic
CPU_INT=${CPU_VAL%.*}
BLOCK_COLOR=$BASE_COLOR

if [ "$CPU_INT" -gt 85 ]; then
    BLOCK_COLOR=$ALERT_COLOR
fi

# Format output string
TEXT_OUT=" /:$DISK_VAL |  $RAM_VAL |  ${CPU_INT}% |  $LOAD_VAL"

# 5. Output
echo "$TEXT_OUT"
echo "$TEXT_OUT"
echo "$BLOCK_COLOR"
