#!/bin/bash
set -x
# Server Tailscale IP
#SERVER_IP="homeserver.sv"
SERVER_IP="192.168.8.87"
USER="mahmoud"

## ssh-keygen -t ed25519
## ssh-copy-id -f mahmoud@homelab.tail9e84e5.ts.net

# Run a single SSH command to get all data at once (saves bandwidth)
STATS=$(ssh -q $USER@$SERVER_IP "
    TEMP=\$(sensors | grep 'Package id 0' | awk '{print \$4}' | cut -d "+" -f2)
    FAN=\$(sensors | grep 'fan1' | awk '{print \$2}')
    #CPU_GHZ=\$(grep "cpu MHz" /proc/cpuinfo |cut -d ":" -f 2 | cut -d "." -f1 | head -1 | sed 's/$/ MHz/')
    LOAD=\$(uptime | awk -F'load average:' '{print \$2}' | cut -d, -f1 | xargs)
    DISK=\$(df -h / | awk 'NR==2 {print \$4}')
    CPU_USAGE=\$(top -bn1 | grep 'Cpu(s)' | awk '{print 100 - \$8 \"%\"}')
    RAM=$(free | awk '/Mem/{printf "%.0f%%\n", ($3/$2)*100}')
    #SWAP=$(free | awk '/Mem/{printf "%.0f%%\n", ($3/$2)*100}')
    # Get network speed (rx/tx) from eth0 or wlan0

    #echo \"  \$CPU_USAGE |  \$FAN |  \$LOAD |  \$DISK |  \$TEMP \"
        echo \"  \$DISK|  \$RAM |  \$CPU_USAGE |  \$TEMP |  \$LOAD |  \$FAN \"

")

# If SSH fails (server offline), show nothing or an error
if [ $? -ne 0 ]; then
    echo "SVR OFFLINE"
    exit 1
fi

# Format the output for i3blocks (using pipes as separators)
echo "$STATS"
