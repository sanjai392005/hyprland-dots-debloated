#!/usr/bin/env bash
WLOGOUT_LAYOUT="$HOME/.config/wlogout/layout"
WLOGOUT_CSS="$HOME/.config/wlogout/style.css"

T_val=600 #top padding
B_val=600 #bottom padding
L_val=350 #left padding
R_val=350 #right padding

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

wlogout --protocol layer-shell --layout "$WLOGOUT_LAYOUT" --css "$WLOGOUT_CSS" -b 4 -T $T_val -B $B_val -L $L_val -R $R_val &
