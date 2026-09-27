#!/bin/bash

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
R_ENABLED=false
R_ACT=1; R_DEACT=20; R_WAIT_IN=0; R_WAIT_OUT=0
R_START=400; R_END=700
R_CMD_IN="xfce4-terminal --drop-down > /dev/null 2>&1 &"; R_CMD_OUT=""

# TOP-LEFT CORNER
TL_ENABLED=true
TL_ACT=10; TL_DEACT=50; TL_WAIT_IN=0; TL_WAIT_OUT=0
TL_CMD_IN="bash '$HOME/.config/i3/scripts2/KDE Plasma/plasma_panel/panel_toggle.sh'"; TL_CMD_OUT=""

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
BR_CMD_IN="i3-msg workspace back_and_forth"; BR_CMD_OUT=""

DELAY=0.05

# Slower polling while the pointer is farther than IDLE_DISTANCE px from every edge
IDLE_DELAY=0.15
IDLE_DISTANCE=200

# --- 3. LOGIC ENGINE ---
# All timing is done in integer milliseconds with bash builtins only,
# so each tick costs a single fork (xdotool).

# "0.25" / "-0.4" / "1" (seconds) -> milliseconds
to_ms() {
    local v=${1#-} int frac
    int=${v%%.*}; [[ "$v" == *.* ]] && frac=${v#*.} || frac=""
    frac=${frac}000; frac=${frac:0:3}
    echo $(( 10#${int:-0} * 1000 + 10#$frac ))
}

ZONES=()
MARGIN=0
declare -A S T WAIT_IN WAIT_OUT
for zone in TL TR BL BR T B L R; do
    enabled="${zone}_ENABLED"
    [[ "${!enabled}" != "true" ]] && continue
    ZONES+=("$zone")
    S[$zone]="out"; T[$zone]=0
    w_in="${zone}_WAIT_IN"; w_out="${zone}_WAIT_OUT"
    WAIT_IN[$zone]=$(to_ms "${!w_in}")
    WAIT_OUT[$zone]=$(to_ms "${!w_out}")
    # Largest activation distance: beyond it no zone can trigger
    act="${zone}_ACT"; (( ${!act} > MARGIN )) && MARGIN=${!act}
done
DELAY_MS=$(to_ms "$DELAY")

# Builtin sleep: read with timeout on a pipe that never receives data
exec {SLEEP_FD}<> <(:)

while true; do
    # Only get mouse location once per loop
    eval "$(xdotool getmouselocation --shell)"

    # EARLY SKIP: pointer far from every edge and nothing is active
    if (( X > MARGIN && X < W - MARGIN && Y > MARGIN && Y < H - MARGIN )); then
        ANY_ACTIVE=false
        for zone in "${ZONES[@]}"; do
            [[ "${S[$zone]}" == "in" || "${T[$zone]}" -ne 0 ]] && { ANY_ACTIVE=true; break; }
        done
        if [[ "$ANY_ACTIVE" == "false" ]]; then
            if (( X > IDLE_DISTANCE && X < W - IDLE_DISTANCE && Y > IDLE_DISTANCE && Y < H - IDLE_DISTANCE )); then
                read -rt "$IDLE_DELAY" -u "$SLEEP_FD"
            else
                read -rt "$DELAY" -u "$SLEEP_FD"
            fi
            continue
        fi
    fi

    # 1. CORNER SHIELD: edges are ignored while the pointer is in an enabled corner
    IN_ANY_CORNER=false
    [[ "$TL_ENABLED" == "true" ]] && (( X <= TL_ACT && Y <= TL_ACT )) && IN_ANY_CORNER=true
    [[ "$TR_ENABLED" == "true" ]] && (( X >= W - TR_ACT && Y <= TR_ACT )) && IN_ANY_CORNER=true
    [[ "$BL_ENABLED" == "true" ]] && (( X <= BL_ACT && Y >= H - BL_ACT )) && IN_ANY_CORNER=true
    [[ "$BR_ENABLED" == "true" ]] && (( X >= W - BR_ACT && Y >= H - BR_ACT )) && IN_ANY_CORNER=true

    for zone in "${ZONES[@]}"; do
        # 2. ZONE EVALUATION
        state="${S[$zone]}"
        if [ "$state" == "out" ]; then thresh="${zone}_ACT"; else thresh="${zone}_DEACT"; fi
        val=${!thresh}

        IN_ZONE=false
        case $zone in
            T) [[ "$IN_ANY_CORNER" == "false" ]] && (( Y <= val && X >= T_START && X <= T_END )) && IN_ZONE=true ;;
            B) [[ "$IN_ANY_CORNER" == "false" ]] && (( Y >= H - val && X >= B_START && X <= B_END )) && IN_ZONE=true ;;
            L) [[ "$IN_ANY_CORNER" == "false" ]] && (( X <= val && Y >= L_START && Y <= L_END )) && IN_ZONE=true ;;
            R) [[ "$IN_ANY_CORNER" == "false" ]] && (( X >= W - val && Y >= R_START && Y <= R_END )) && IN_ZONE=true ;;
            TL) (( X <= val && Y <= val )) && IN_ZONE=true ;;
            TR) (( X >= W - val && Y <= val )) && IN_ZONE=true ;;
            BL) (( X <= val && Y >= H - val )) && IN_ZONE=true ;;
            BR) (( X >= W - val && Y >= H - val )) && IN_ZONE=true ;;
        esac

        # 3. HYSTERESIS STATE MACHINE
        cmd_in="${zone}_CMD_IN"; cmd_out="${zone}_CMD_OUT"

        if [ "$state" == "out" ]; then
            if [ "$IN_ZONE" == "true" ]; then
                T[$zone]=$(( T[$zone] + DELAY_MS ))
                if (( T[$zone] >= WAIT_IN[$zone] )); then
                    [[ -n "${!cmd_in}" ]] && eval "${!cmd_in}"
                    S[$zone]="in"; T[$zone]=0
                fi
            else T[$zone]=0; fi
        else
            if [ "$IN_ZONE" == "false" ]; then
                T[$zone]=$(( T[$zone] + DELAY_MS ))
                if (( T[$zone] >= WAIT_OUT[$zone] )); then
                    [[ -n "${!cmd_out}" ]] && eval "${!cmd_out}"
                    S[$zone]="out"; T[$zone]=0
                fi
            else T[$zone]=0; fi
        fi
    done
    read -rt "$DELAY" -u "$SLEEP_FD"
done
