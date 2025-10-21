#!/bin/bash

is_recorder_running() {
    pgrep -x wl-screenrec >/dev/null
}

TMP_FILE="/tmp/recording_screen_audio.mp4"
APP_NAME="Screen with audio Capture"

toggle_recorder() {
    if is_recorder_running; then
        kill $(pgrep -x wl-screenrec)
    else
        notify-send -e -t 2000 "Started capturing the screen with audio to clipboard."
        timeout 600 wl-screenrec --max-fps 60 -b "2 MB" --audio --audio-bitrate "48 kB" --audio-device=alsa_output.usb-CEntrance_CEntrance_Dacportable-00.analog-stereo.monitor -f $TMP_FILE
        wl-copy -t text/uri-list file://$TMP_FILE 

        if [ $? -eq 124 ]; then
            notify-send -e -t 2000 "Screen capturing timed out."
        else
            notify-send -e -t 2000 "Screen capturing was stopped."
        fi
    fi
    }

toggle_recorder
