#!/bin/bash

#SERVER_IP="192.168.8.87"
SERVER_IP="100.100.1.1"
USER="mahmoud"
SOCKET="$HOME/.ssh/control-${USER}@${SERVER_IP}:22"

# 1. Verify or establish the persistent background tunnel
if ! ssh -O check -S "$SOCKET" "$USER@$SERVER_IP" 2>/dev/null; then
    ssh -M -S "$SOCKET" -fN -o ControlPersist=yes "$USER@$SERVER_IP" 2>/dev/null
fi

# 2. Pull metrics at once from the server
# FIXED: Using -bn2 and tail to grab real-time delta stats instead of boot-up averages
DATA=$(ssh -q -o ConnectTimeout=1 -S "$SOCKET" "$USER@$SERVER_IP" "
    CPU_NUM=\$(top -bn2 -d 0.01 | grep 'Cpu(s)' | tail -n 1 | awk '{print 100 - \$8}')
    TEMP_NUM=\$(sensors 2>/dev/null | grep 'Package id 0' | awk '{print \$4}' | tr -d '+' | cut -d. -f1 | sed 's/°C//g')

    LOAD=\$(uptime | awk -F'load average:' '{print \$2}' | cut -d, -f1 | xargs)
    FAN=\$(sensors 2>/dev/null | grep 'fan1' | awk '{print \$2}')
    RAM=\$(free | awk '/Mem/{printf \"%.0f%%\", (\$3/\$2)*100}')

    DISK_ROOT=\$(df -h / | awk 'NR==2 {print \$4}')
    DISK_HL=\$(df -h /mnt/homelab 2>/dev/null | awk 'NR==2 {print \$4}')
    DISK_PD=\$(df -h /mnt/personal_data 2>/dev/null | awk 'NR==2 {print \$4}')

    [ -z \"\$DISK_HL\" ] && DISK_HL=\"N/A\"
    [ -z \"\$DISK_PD\" ] && DISK_PD=\"N/A\"
    [ -z \"\$FAN\" ] && FAN=\"N/A\"
    [ -z \"\$TEMP_NUM\" ] && TEMP_NUM=\"0\"

    #echo \"\$CPU_NUM,\$TEMP_NUM, Root:\$DISK_ROOT HL:\$DISK_HL PD:\$DISK_PD |  \$RAM |  \$(printf \"%.0f%%\" \$CPU_NUM) |  \${TEMP_NUM}°C |  \$LOAD |  \$FAN RPM\"
    echo \"\$CPU_NUM,\$TEMP_NUM, /:\$DISK_ROOT HL:\$DISK_HL PD:\$DISK_PD |  \$RAM |  \$(printf \"%.0f%%\" \$CPU_NUM) |  \${TEMP_NUM}°C |  \$LOAD |  \$FAN\"
")

if [ $? -ne 0 ] || [ -z "$DATA" ]; then
    echo "SVR OFFLINE"
    echo "SVR OFFLINE"
    echo "#FF0000"
    exit 1
fi

# 3. Parse variables
CPU_VAL=$(echo "$DATA" | cut -d, -f1)
TEMP_VAL=$(echo "$DATA" | cut -d, -f2)
TEXT_OUT=$(echo "$DATA" | cut -d, -f3-)

# 4. Safely convert float CPU to Integer for pure Bash math loops
CPU_INT=$(echo "$CPU_VAL" | cut -d. -f1)

# Default color (Ice Blue / Cyan style)
BLOCK_COLOR="#00D2FF"

# 5. Alarm logic checking the clean integer
if [ "$CPU_INT" -gt 85 ] || [ "$TEMP_VAL" -gt 75 ]; then
    BLOCK_COLOR="#FF9800" # Hot Neon Orange Alert
fi

# 6. Output exactly three lines so i3blocks catches the color mapping
echo "$TEXT_OUT"
echo "$TEXT_OUT"
echo "$BLOCK_COLOR"
