#!/bin/sh

DATA=$(curl -X GET 'http://nuc.oktorp.se:8000/solar_api/v1/GetPowerFlowRealtimeData.fcgi' --silent | jq '.Body.Data.Site')

FROM_SUN=$(echo $DATA | jq '.P_PV' | bc -l)
CONSUMPTION=$(echo $DATA | jq '.P_Load' | bc -l)
BUYING=$(echo $DATA | jq '.P_Grid' | bc -l)
AUTONOMY=$(echo $DATA | jq '.rel_Autonomy' | bc -l)

CONSUMPTION_IN_KW=$(echo "scale=2; $CONSUMPTION/1000" | bc -l)
FROM_SUN_IN_KW=$(echo "scale=2; $FROM_SUN/1000" | bc -l)
BUYING_IN_KW=$(echo "scale=2; $BUYING/1000" | bc -l)

PERCENT_BOUGHT=$(bc -l <<< "100-${AUTONOMY}" | awk '{printf("%d\n",$1 + 0.5)}')

case "$1" in
    production)
        echo "$FROM_SUN_IN_KW kW"
        ;;
    consumption)
        echo "$CONSUMPTION_IN_KW kW"
        ;;
    buying)
        echo "$BUYING_IN_KW kW"
        ;;
    flow)
        if (( ${BUYING%%.*} > 0)); then
            echo "{\"text\": \"${BUYING_IN_KW#-} kW\", \"percent\":$PERCENT_BOUGHT, \"class\": \"buying\"}" 
        else
            SELLING_IN_KW=$(echo ${CONSUMPTION_IN_KW}+${FROM_SUN_IN_KW} | bc -l)
            echo "{\"text\": \"$SELLING_IN_KW kW\", \"percent\":100, \"class\": \"selling\"}" 
        fi
        ;;
    ratio)
        echo "$PERCENT_BOUGHT %"
        ;;
esac

#if (( ${BUYING%%.*} > 0)); then
#    echo "{\"text\":\" ${BUYING_IN_KW#-}/${CONSUMPTION_IN_KW} kW \",\"tooltip\":\"Buying: ${BUYING_IN_KW#-} kW. Producing: $FROM_SUN_IN_KW kW. Consuming: ${CONSUMPTION_IN_KW} kW\",\"class\":\"buying\"}"
#else
#    echo "{\"text\":\" $FROM_SUN_IN_KW/${CONSUMPTION_IN_KW} kW\",\"tooltip\":\"Buying: ${BUYING_IN_KW#-} kW. Producing: $FROM_SUN_IN_KW kW. Consuming: ${CONSUMPTION_IN_KW} kW\",\"class\":\"selling\"}"
#fi

#echo "%{F#FDD835}%{F-} $FROM_SUN_IN_KW kW %{F#1C1C1C} | %{F-} %{F#6f97ec}ﮣ%{F-} $CONSUMPTION_IN_KW kW %{F#1C1C1C} | $FLOW"
