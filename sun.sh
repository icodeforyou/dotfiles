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

if (( ${BUYING%%.*} > 0)); then
    BUYING_COLOR="#ff6565" # red (buying juice)
    ARROW=""
    FLOW="%{F-} %{F$BUYING_COLOR}${ARROW}%{F-} $PERCENT_BOUGHT %"
else
    BUYING_COLOR="#61c766" # green
    ARROW=""
    FLOW="%{F-} %{F$BUYING_COLOR}${ARROW}%{F-} ${BUYING_IN_KW#-} kW"
fi

echo "%{F#FDD835}%{F-} $FROM_SUN_IN_KW kW %{F#1C1C1C} | %{F-} %{F#6f97ec}ﮣ%{F-} $CONSUMPTION_IN_KW kW %{F#1C1C1C} | $FLOW"
