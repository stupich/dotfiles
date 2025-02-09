#!/bin/bash

is_recorder_running() {
    pgrep -x wf-recorder >/dev/null
}

TMP_FILE="/tmp/recording_screen_audio.mp4"
APP_NAME="Screen with audio Capture"

toggle_recorder() {
    if is_recorder_running; then
        kill $(pgrep -x wf-recorder)
    else
        notify-send -a "$APP_NAME" "Started capturing the screen with audio to clipboard."
        timeout 600 wf-recorder -y --audio=alsa_output.usb-CEntrance_CEntrance_Dacportable-00.analog-stereo.monitor -f $TMP_FILE
        wl-copy -t text/uri-list file://$TMP_FILE 

        if [ $? -eq 124 ]; then
            notify-send -a "$APP_NAME" "Screen capturing timed out."
        else
            notify-send -a "$APP_NAME" "Screen capturing was stopped."
        fi
    fi
    }

toggle_recorder
