#!/bin/bash

STEP=5
DELAY=0.01

while true; do
	[[ -f /tmp/mk_left ]] && ydotool mousemove -- -$STEP 0
	[[ -f /tmp/mk_right ]] && ydotool mousemove -- $STEP 0
	[[ -f /tmp/mk_up ]] && ydotool mousemove -- 0 $STEP
	[[ -f /tmp/mk_down ]] && ydotool mousemove -- 0 -$STEP
	sleep $DELAY
done
