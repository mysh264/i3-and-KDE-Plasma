#!/bin/bash
trap 'pkill -P $$' EXIT

# --- 1. SCREEN RESOLUTION AUTO-DETECTION ---
RES=$(xdpyinfo | grep dimensions | awk '{print $2}')
W=$(echo $RES | cut -d'x' -f1)
H=$(echo $RES | cut -d'x' -f2)

# --- 2. CONFIGURATION SECTION ---
# TOP EDGE
T_ENABLED=false
T_ACT=1; T_DEACT=80; T_WAIT_IN=0.2; T_WAIT_OUT=0.4
T_START=100; T_END=$((W - 100))
T_CMD_IN=""; T_CMD_OUT=""

# BOTTOM EDGE
B_ENABLED=true
B_ACT=1; B_DEACT=70; B_WAIT_IN=0; B_WAIT_OUT=0.4
B_START=0; B_END=$W
B_CMD_IN="bash '$HOME/.config/i3/scripts2/Screen Edges/i3bar_status.sh'"; B_CMD_OUT="i3-msg bar hidden_state hide"

# LEFT EDGE
L_ENABLED=false
L_ACT=1; L_DEACT=100; L_WAIT_IN=0.2; L_WAIT_OUT=0.4
L_START=0; L_END=$H
L_CMD_IN=""; L_CMD_OUT=""

# RIGHT EDGE (xfce4-terminal zone)
R_ENABLED=true
R_ACT=1; R_DEACT=20; R_WAIT_IN=0; R_WAIT_OUT=0
R_START=400; R_END=700
R_CMD_IN="xfce4-terminal --drop-down"; R_CMD_OUT=""

# TOP-LEFT CORNER
TL_ENABLED=true
TL_ACT=10; TL_DEACT=50; TL_WAIT_IN=0; TL_WAIT_OUT=0
TL_CMD_IN="bash '$HOME/.config/i3/scripts2/KDE Plasma {OSD + Notify + Panel}/plasma_panel/panel_toggle.sh'"; TL_CMD_OUT=""

# TOP-RIGHT CORNER
TR_ENABLED=true
TR_ACT=10; TR_DEACT=50; TR_WAIT_IN=0; TR_WAIT_OUT=0
TR_CMD_IN="i3-msg workspace 97"; TR_CMD_OUT=""

# BOTTOM-LEFT CORNER
BL_ENABLED=false
BL_ACT=10; BL_DEACT=50; BL_WAIT_IN=0.3; BL_WAIT_OUT=0.5
BL_CMD_IN=""; BL_CMD_OUT=""

# BOTTOM-RIGHT CORNER
BR_ENABLED=true
BR_ACT=10; BR_DEACT=50; BR_WAIT_IN=0; BR_WAIT_OUT=0
BR_CMD_IN="i3-msg bar mode toggle"; BR_CMD_OUT=""

DELAY=0.05

# --- 3. LOGIC ENGINE ---
declare -A S T
for zone in T B L R TL TR BL BR; do S[$zone]="out"; T[$zone]=0; done

while true; do
    # Only get mouse location once per loop
    eval $(xdotool getmouselocation --shell)

    # 1. CPU SAVER: PRE-CALCULATE CORNER SHIELD
    # Only checks corners that are actually enabled.
    IN_ANY_CORNER=false
    [[ "$TL_ENABLED" == "true" && "$X" -le "$TL_ACT" && "$Y" -le "$TL_ACT" ]] && IN_ANY_CORNER=true
    [[ "$TR_ENABLED" == "true" && "$X" -ge "$((W - TR_ACT))" && "$Y" -le "$TR_ACT" ]] && IN_ANY_CORNER=true
    [[ "$BL_ENABLED" == "true" && "$X" -le "$BL_ACT" && "$Y" -ge "$((H - BL_ACT))" ]] && IN_ANY_CORNER=true
    [[ "$BR_ENABLED" == "true" && "$X" -ge "$((W - BR_ACT))" && "$Y" -ge "$((H - BR_ACT))" ]] && IN_ANY_CORNER=true

    for zone in TL TR BL BR T B L R; do
        # --- THE MASTER CPU TOGGLE ---
        # If the zone is disabled, we skip the entire check immediately.
        enabled="${zone}_ENABLED"
        [[ "${!enabled}" != "true" ]] && continue

        # 2. ZONE EVALUATION
        state="${S[$zone]}"
        if [ "$state" == "out" ]; then thresh="${zone}_ACT"; else thresh="${zone}_DEACT"; fi
        val=${!thresh}

        IN_ZONE=false
        case $zone in
            T) [[ "$Y" -le "$val" && "$X" -ge "${T_START}" && "$X" -le "${T_END}" && "$IN_ANY_CORNER" == "false" ]] && IN_ZONE=true ;;
            B) [[ "$Y" -ge "$((H - val))" && "$X" -ge "${B_START}" && "$X" -le "${B_END}" && "$IN_ANY_CORNER" == "false" ]] && IN_ZONE=true ;;
            L) [[ "$X" -le "$val" && "$Y" -ge "${L_START}" && "$Y" -le "${L_END}" && "$IN_ANY_CORNER" == "false" ]] && IN_ZONE=true ;;
            R) [[ "$X" -ge "$((W - val))" && "$Y" -ge "${R_START}" && "$Y" -le "${R_END}" && "$IN_ANY_CORNER" == "false" ]] && IN_ZONE=true ;;
            TL) [[ "$X" -le "$val" && "$Y" -le "$val" ]] && IN_ZONE=true ;;
            TR) [[ "$X" -ge "$((W - val))" && "$Y" -le "$val" ]] && IN_ZONE=true ;;
            BL) [[ "$X" -le "$val" && "$Y" -ge "$((H - val))" ]] && IN_ZONE=true ;;
            BR) [[ "$X" -ge "$((W - val))" && "$Y" -ge "$((H - val))" ]] && IN_ZONE=true ;;
        esac

        # 3. HYSTERESIS STATE MACHINE
        cmd_in="${zone}_CMD_IN"; cmd_out="${zone}_CMD_OUT"
        wait_in="${zone}_WAIT_IN"; wait_out="${zone}_WAIT_OUT"

        if [ "$state" == "out" ]; then
            if [ "$IN_ZONE" == "true" ]; then
                T[$zone]=$(echo "${T[$zone]} + $DELAY" | bc)
                # Convert wait to absolute for comparison
                ABS_WAIT=$(echo "${!wait_in}" | sed 's/-//')
                if (( $(echo "${T[$zone]} >= $ABS_WAIT" | bc -l) )); then
                    [[ -n "${!cmd_in}" ]] && eval "${!cmd_in}"
                    S[$zone]="in"; T[$zone]=0
                fi
            else T[$zone]=0; fi
        else
            if [ "$IN_ZONE" == "false" ]; then
                T[$zone]=$(echo "${T[$zone]} + $DELAY" | bc)
                ABS_WAIT=$(echo "${!wait_out}" | sed 's/-//')
                if (( $(echo "${T[$zone]} >= $ABS_WAIT" | bc -l) )); then
                    [[ -n "${!cmd_out}" ]] && eval "${!cmd_out}"
                    S[$zone]="out"; T[$zone]=0
                fi
            else T[$zone]=0; fi
        fi
    done
    sleep "$DELAY"
done
