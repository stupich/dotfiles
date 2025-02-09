#!/bin/bash

is_recorder_running() {
    pgrep -x wf-recorder >/dev/null
}

TMP_FILE="/tmp/recording_screen.mp4"
APP_NAME="Screen Capture"

toggle_recorder() {
    if is_recorder_running; then
        kill $(pgrep -x wf-recorder)
    else
        notify-send -a "$APP_NAME" "Started capturing the screen to clipboard."
        timeout 600 wf-recorder -y -f $TMP_FILE
        wl-copy -t text/uri-list file://$TMP_FILE 

        if [ $? -eq 124 ]; then
            notify-send -a "$APP_NAME" "Screen capturing timed out."
        else
            notify-send -a "$APP_NAME" "Screen capturing was stopped."
        fi
    fi
    }

toggle_recorder
