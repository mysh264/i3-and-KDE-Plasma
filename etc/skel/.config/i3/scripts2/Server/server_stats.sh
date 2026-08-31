#!/bin/bash

# Configuration
SERVER_IP="100.100.1.1"
USER="mahmoud"
KEY_PATH="$HOME/.ssh/id_ed25519"
SOCKET="$HOME/.ssh/sockets/control-${USER}@${SERVER_IP}_22"

# 1. Establish Master Connection (clean up stale sockets if check fails)
mkdir -p "$HOME/.ssh/sockets"
if ! ssh -O check -S "$SOCKET" "$USER@$SERVER_IP" 2>/dev/null; then
    rm -f "$SOCKET"
    ssh -i "$KEY_PATH" -M -S "$SOCKET" -fN -o ControlPersist=1h "$USER@$SERVER_IP"
fi

# 2. Pull metrics using an SSH Heredoc
DATA=$(ssh -i "$KEY_PATH" -q -o ConnectTimeout=1 -S "$SOCKET" "$USER@$SERVER_IP" << 'EOF'
    # Calculate CPU usage
    CPU_NUM=$(top -bn2 -d 0.01 | grep 'Cpu(s)' | tail -n 1 | awk '{print 100 - $8}')

    # Gather other metrics
    RAM=$(free | awk '/Mem/{printf "%.0f%%", ($3/$2)*100}')
    DISK_ROOT=$(df -h / | awk 'NR==2 {print $4}')
    LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | xargs)
    TEMP_NUM=$(sensors 2>/dev/null | grep 'Package id 0' | awk '{print $4}' | tr -d '+' | cut -d. -f1 | sed 's/°C//g')
    FAN=$(sensors 2>/dev/null | grep 'fan1' | awk '{print $2}')
    DISK_HL=$(df -h /home/mahmoud/mnt/HDD2TB/Docker 2>/dev/null | awk 'NR==2 {print $4}')
    DISK_PD=$(df -h /home/mahmoud/mnt/HDD2TB/Personal 2>/dev/null | awk 'NR==2 {print $4}')

    # Return as comma-separated values
    echo "$CPU_NUM,$RAM,$DISK_ROOT,$LOAD,$TEMP_NUM,$FAN,$DISK_HL,$DISK_PD"
EOF
)

# If connection fails
if [ $? -ne 0 ] || [ -z "$DATA" ]; then
    echo "SVR OFFLINE"
    echo "SVR OFFLINE"
    echo "#FF0000"
    exit 0
fi

# 3. Parse variables cleanly using IFS
IFS=',' read -r CPU_VAL RAM_VAL DISK_VAL LOAD_VAL TEMP_VAL FAN_VAL DISK_HL_VAL DISK_PD_VAL <<< "$DATA"

# 4. Logic and Formatting
BASE_COLOR="#00FF41" # Matrix Green
ALERT_COLOR="#FF3131" # Terminal Red

# Round CPU for color logic
CPU_INT=${CPU_VAL%.*}
BLOCK_COLOR=$BASE_COLOR

# Trigger alert if CPU > 85% or Temperature > 80°C
if [ "$CPU_INT" -gt 85 ] || [ "${TEMP_VAL:-0}" -gt 80 ]; then
    BLOCK_COLOR=$ALERT_COLOR
fi

# Format output string using compact icons (Root, Docker, Personal, RAM, CPU, Temp)
TEXT_OUT=" $DISK_VAL |  $DISK_HL_VAL |  $DISK_PD_VAL |  $RAM_VAL |  ${CPU_INT}% |  ${TEMP_VAL}°C"

# 5. Output for i3blocks
echo "$TEXT_OUT"
echo "$TEXT_OUT"
echo "$BLOCK_COLOR"
