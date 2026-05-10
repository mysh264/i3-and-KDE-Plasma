#!/bin/bash

# --- 1. SCREEN RESOLUTION AUTO-DETECTION ---
# This ensures coordinates are always correct for your specific display.
RES=$(xdpyinfo | grep dimensions | awk '{print $2}')
W=$(echo $RES | cut -d'x' -f1)
H=$(echo $RES | cut -d'x' -f2)

# --- 2. CONFIGURATION SECTION ---
# TIP: You can use pixels (e.g., 55) or math (e.g., $((H / 20)) for 5%)

# TOP EDGE (Plasma Panel)
T_ACT=1; T_DEACT=80; T_WAIT_IN=-0.2; T_WAIT_OUT=-0.4
T_CMD_IN=""; T_CMD_OUT=""

# BOTTOM EDGE (i3bar)
B_ACT=1; B_DEACT=70; B_WAIT_IN=-0.2; B_WAIT_OUT=0.4
B_CMD_IN="bash '$HOME/.config/i3/scripts2/Screen Edges/i3bar_status.sh'"; B_CMD_OUT="i3-msg bar hidden_state hide"

# LEFT EDGE
L_ACT=1; L_DEACT=100; L_WAIT_IN=-0.2; L_WAIT_OUT=-0.4
L_CMD_IN=""; L_CMD_OUT=""

# RIGHT EDGE
R_ACT=1; R_DEACT=100; R_WAIT_IN=-0.2; R_WAIT_OUT=-0.4
R_CMD_IN="xfce4-terminal --drop-down"; R_CMD_OUT=""

# CORNERS (Example: Top-Left)
TL_ACT=10; TL_DEACT=50; TL_WAIT_IN=-0.3; TL_WAIT_OUT=-0.5
TL_CMD_IN="bash '$HOME/.config/i3/scripts2/KDE Plasma {OSD + Notify + Panel}/plasma_panel/panel_toggle.sh'"; TL_CMD_OUT=""

TR_ACT=10; TR_DEACT=50; TR_WAIT_IN=-0.3; TR_WAIT_OUT=-0.5
TR_CMD_IN="i3-msg workspace 97"; TR_CMD_OUT=""

BL_ACT=-10; BL_DEACT=-50; BL_WAIT_IN=0.3; BL_WAIT_OUT=0.5
BL_CMD_IN=""; BL_CMD_OUT=""

BR_ACT=10; BR_DEACT=50; BR_WAIT_IN=-0.3; BR_WAIT_OUT=-0.5
BR_CMD_IN="i3-msg bar mode toggle"; BR_CMD_OUT=""

DELAY=0.05

# --- 3. LOGIC ENGINE ---
declare -A S T
for zone in T B L R TL TR BL BR; do S[$zone]="out"; T[$zone]=0; done

while true; do
    eval $(xdotool getmouselocation --shell)

    # Function to evaluate if mouse is inside the threshold
    # Args: $1=ZonePrefix, $2=CurrentState
    is_mouse_in_zone() {
        local z=$1; local state=$2
        local thresh

        # Determine which threshold to use based on current state (Hysteresis)
        if [ "$state" == "out" ]; then thresh="${z}_ACT"; else thresh="${z}_DEACT"; fi
        local val=${!thresh}

        case $z in
            T)  [[ "$Y" -le "$val" && "$X" -gt "${TL_DEACT}" && "$X" -lt "$((W - TR_DEACT))" ]] && echo true || echo false ;;
            B)  [[ "$Y" -ge "$((H - val))" && "$X" -gt "${BL_DEACT}" && "$X" -lt "$((W - BR_DEACT))" ]] && echo true || echo false ;;
            L)  [[ "$X" -le "$val" && "$Y" -gt "${TL_DEACT}" && "$Y" -lt "$((H - BL_DEACT))" ]] && echo true || echo false ;;
            R)  [[ "$X" -ge "$((W - val))" && "$Y" -gt "${TR_DEACT}" && "$Y" -lt "$((H - BR_DEACT))" ]] && echo true || echo false ;;
            TL) [[ "$X" -le "$val" && "$Y" -le "$val" ]] && echo true || echo false ;;
            TR) [[ "$X" -ge "$((W - val))" && "$Y" -le "$val" ]] && echo true || echo false ;;
            BL) [[ "$X" -le "$val" && "$Y" -ge "$((H - val))" ]] && echo true || echo false ;;
            BR) [[ "$X" -ge "$((W - val))" && "$Y" -ge "$((H - val))" ]] && echo true || echo false ;;
        esac
    }

    for zone in TL TR BL BR T B L R; do
        IN_ZONE=$(is_mouse_in_zone "$zone" "${S[$zone]}")

        cmd_in="${zone}_CMD_IN"; cmd_out="${zone}_CMD_OUT"
        wait_in="${zone}_WAIT_IN"; wait_out="${zone}_WAIT_OUT"

        if [ "${S[$zone]}" == "out" ]; then
            if [ "$IN_ZONE" == "true" ]; then
                T[$zone]=$(echo "${T[$zone]} + $DELAY" | bc)
                if (( $(echo "${T[$zone]} >= ${!wait_in}" | bc -l) )); then
                    eval "${!cmd_in}"; S[$zone]="in"; T[$zone]=0
                fi
            else T[$zone]=0; fi
        else
            if [ "$IN_ZONE" == "false" ]; then
                T[$zone]=$(echo "${T[$zone]} + $DELAY" | bc)
                if (( $(echo "${T[$zone]} >= ${!wait_out}" | bc -l) )); then
                    eval "${!cmd_out}"; S[$zone]="out"; T[$zone]=0
                fi
            else T[$zone]=0; fi
        fi
    done

    sleep "$DELAY"
done
