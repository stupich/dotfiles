wayfreeze & PID=$!; sleep .1; grim -g "$(slurp)" - | wl-copy; kill $PID
notify-send -e -t 2000 "Copied area screenshot to clipboard"
