#!/usr/bin/env bash

# Default step for volume adjustment
STEP=5
LOCKFILE="/tmp/volumecontrol.lock"

# Function to show notification
notify_volume() {
    local vol=$(pamixer --get-volume)
    local mute=$(pamixer --get-mute)
    if [ "$mute" == "true" ]; then
        notify-send -a "Volume Control" -u low -r 91190 -i audio-volume-muted "Muted"
    else
        notify-send -a "Volume Control" -u low -r 91190 -i audio-volume-high "Volume: ${vol}%"
    fi
}

# Ensure only one instance runs at a time
exec 200>"$LOCKFILE"
flock -n 200 || exit 1

# Main script logic
case "$1" in
    increase)
        amixer -q -D pulse sset Master $STEP%+
        ;;
    decrease)
        amixer -q -D pulse sset Master $STEP%-
        ;;
    toggle-mute)
        pamixer --toggle-mute
        ;;
    *)
        echo "Usage: $0 {increase|decrease|toggle-mute}"
        exit 1
        ;;
esac

# Show volume notification
notify_volume

# Release the lock
exec 200>&-
