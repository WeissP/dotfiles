#!/bin/bash

Mouse_name="ELECOM ELECOM TrackBall Mouse"

Mouse_ID=$(xinput list | grep "$Mouse_name" | head -n 1 | sed -r 's/.*id=([0-9]+).*/\1/')
if [ -z "$Mouse_ID" ]; then
    echo "ELECOM TrackBall Mouse not found"
else
    xinput set-prop ${Mouse_ID} 'libinput Button Scrolling Button' 9
    xinput set-prop ${Mouse_ID} "libinput Scroll Method Enabled" 0 0 1
fi
