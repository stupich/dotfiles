#!/bin/bash

is_recorder_running() {
    pgrep -x wf-recorder >/dev/null
}

TMP_FILE="/tmp/recording_area.mp4"
APP_NAME="Area Capture"

toggle_recorder() {
    if is_recorder_running; then
        kill $(pgrep -x wf-recorder)
    else
        GEOMETRY=$(slurp)
        if [[ ! -z "$GEOMETRY" ]]; then
            if [ -f "$TMP_FILE" ]; then
                rm "$TMP_FILE"
            fi

            notify-send -a "$APP_NAME" "Started capturing area to clipboard."
            timeout 600 wf-recorder -y -g "$GEOMETRY" -f $TMP_FILE
            wl-copy -t text/uri-list file://$TMP_FILE 

            if [ $? -eq 124 ]; then
                notify-send -a "$APP_NAME" "Area capturing timed out."
            else
                notify-send -a "$APP_NAME" "Area capturing was stopped."
            fi
        fi
    fi
}

toggle_recorder
