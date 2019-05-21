#!/bin/sh

# turn on natural scrolling

input_id() {
    INPUT_ID=$(
        xinput list | awk -v pattern="$1" '
        $0 ~ pattern {
            for (i = 1; i <= NF; i++) {
                if ($i ~ "^id=") {
                    gsub("id=", "", $i);
                    print $i;
                }
            }
        }'
    )
}

feature_id() {
    # echo ... xinput list-props $1
    FEATURE_ID=$(
        xinput list-props $1 2>/dev/null | awk '
        /libinput Natural Scrolling Enabled \(/ {
            gsub("[\(\):]", "", $5);
            print $5;
        }'
    )
}

input_id "SynPS/2 Synaptics TouchPad"
feature_id $INPUT_ID
# echo ... xinput set-prop $INPUT_ID $FEATURE_ID 1
xinput set-prop $INPUT_ID $FEATURE_ID 1 2>/dev/null

input_id "Apple Inc. Magic Trackpad 2"
feature_id $INPUT_ID
# echo ... xinput set-prop $INPUT_ID $FEATURE_ID 1
xinput set-prop $INPUT_ID $FEATURE_ID 1 2>/dev/null
