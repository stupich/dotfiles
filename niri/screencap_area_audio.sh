#!/bin/bash

is_recorder_running() {
    pgrep -x wl-screenrec >/dev/null
}

TMP_FILE="/tmp/recording_area_audio.mp4"
APP_NAME="Area Capture with Audio"

toggle_recorder() {
    if is_recorder_running; then
        kill $(pgrep -x wl-screenrec)
    else
        GEOMETRY=$(slurp)
        if [[ ! -z "$GEOMETRY" ]]; then
            if [ -f "$TMP_FILE" ]; then
                rm "$TMP_FILE"
            fi

            notify-send -e -t 2000 "Started capturing area with audio to clipboard."
            timeout 600 wl-screenrec -b "2 MB" --audio --audio-bitrate "48 kB" --audio-device=alsa_output.usb-CEntrance_CEntrance_Dacportable-00.analog-stereo.monitor -g "$GEOMETRY" -f $TMP_FILE
            wl-copy -t text/uri-list file://$TMP_FILE 

            if [ $? -eq 124 ]; then
                notify-send -e -t 2000 "Area capturing timed out."
            else
                notify-send -e -t 2000 "Area capturing was stopped."
            fi
        fi
    fi
}

toggle_recorder
