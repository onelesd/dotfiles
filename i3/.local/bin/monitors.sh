#!/bin/bash

hdmi_monitor="DP1"
laptop_monitor="eDP1"

config_closed_lid() {
    xrandr  --output $laptop_monitor --off \
            --output $hdmi_monitor --auto --primary
}

config_open_lid() {
    xrandr  --output $hdmi_monitor --off \
            --output $laptop_monitor --auto --primary
}

if [ "$1" == "lidclosed" ]; then
    config_closed_lid
elif [ "$1" == "lidopen" ]; then
    config_open_lid
else
    echo "Unrecognised action: $1"
fi
