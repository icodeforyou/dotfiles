#!/usr/bin/bash

BASE_DIR="$( readlink -f "$(dirname "$0")" )"
DUNST_ENABLED_ICON="$BASE_DIR/enabled.png"
DUNST_DISABLED_ICON="$BASE_DIR/disabled.png"

function enable() {
    rm -f /tmp/.dunst-disabled

    pkill -USR2 -f /usr/bin/dunst
    notify-send "Dunst" "Notifications enabled" -u normal \
        -i "$DUNST_ENABLED_ICON"
}

function disable() {
    notify-send "Dunst" "Notifications disabled" \
        -u normal \
        -i "$DUNST_DISABLED_ICON" \
        -t 2900
    sleep 3

    pkill -USR1 -f /usr/bin/dunst

    touch /tmp/.dunst-disabled
}

function toggle() {
    if [[ -f "/tmp/.dunst-disabled" ]]; then
        enable
    else
        disable
    fi
}

function status() {
    if [[ -f "/tmp/.dunst-disabled" ]]; then
        echo "$ICON_DISABLED"
    else
        echo "$ICON_ENABLED"
    fi
}

case "$1" in
    toggle)
        toggle
        ;;
    disable)
        disable
        ;;
    enable)
        enable
        ;;
    status)
        ICON_DISABLED="$2"
        ICON_ENABLED="$3"
        status
        ;;
esac
