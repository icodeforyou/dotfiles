#!/bin/bash

function main() {
    DEFAULT_SOURCE=$(pw-record --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: description="\(.*\)" prio=[[:digit:]]\+$/\1/p'|awk '{print $(NF-2)" "$(NF-1)" "$NF}')
    DEFAULT_SINK_ID=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*\([[:digit:]]\+\):.*$/\1/p')
    DEFAULT_SINK=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: description="\(.*\)" prio=[[:digit:]]\+$/\1/p'|awk '{print $(NF-2)" "$(NF-1)" "$NF}')
    VOLUME=$(pactl list sinks | sed -n "/Mottagare #${DEFAULT_SINK_ID}/,/Volym/ s!^[[:space:]]\+Volym:.* \([[:digit:]]\+\)%.*!\1!p" | head -n1)
    IS_MUTED=$(pactl list sinks | sed -n "/Mottagare #${DEFAULT_SINK_ID}/,/Tyst/ s/Tyst: \(ja\)/\1/p")

    action=$1
    if [ "${action}" == "up" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +10%
    elif [ "${action}" == "down" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ -10%
    elif [ "${action}" == "mute" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    else
        if [ "${IS_MUTED}" != "" ]; then
            echo " ${DEFAULT_SOURCE} |   MUTED ${DEFAULT_SINK}"
        else
            echo " ${DEFAULT_SOURCE} |    ${VOLUME}% ${DEFAULT_SINK}"
        fi
    fi
}

main "$@"
