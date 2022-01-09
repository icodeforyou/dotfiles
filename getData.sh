#!/bin/bash

#curl 'https://www.solarweb.com/ActualData/GetCompareDataForPvSystem?pvSystemId=d0529f88-81cb-4257-bd1a-3976ef3432e7&_=1631381486899' \
#  -H 'Connection: keep-alive' \
#  -H 'sec-ch-ua: "Chromium";v="92", " Not A;Brand";v="99", "Google Chrome";v="92"' \
#  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
#  -H 'X-Requested-With: XMLHttpRequest' \
#  -H 'sec-ch-ua-mobile: ?0' \
#  -H 'User-Agent: Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36' \
#  -H 'Sec-Fetch-Site: same-origin' \
#  -H 'Sec-Fetch-Mode: cors' \
#  -H 'Sec-Fetch-Dest: empty' \
#  -H 'Referer: https://www.solarweb.com/PvSystems/PvSystem?pvSystemId=d0529f88-81cb-4257-bd1a-3976ef3432e7' \
#  -H 'Accept-Language: sv-SE,sv;q=0.9,en-US;q=0.8,en;q=0.7' \
#  -H $'Cookie: CookieConsent={stamp:%270uAxb/Mz4gITFrlxPUBTN9y8B1XG85dk9KY+Dc3KJhNn4+sFk+onyQ==%27%2Cnecessary:true%2Cpreferences:true%2Cstatistics:true%2Cmarketing:true%2Cver:1%2Cutc:1631250309476%2Cregion:%27se%27}; _ga=GA1.2.1089465435.1631250310; _gid=GA1.2.1123066530.1631250310; lbc=\u0021fGyBoPuwwPNwEa/z57Dg87s/SvNbnATDBlZ4Ztjh03p/uAoJ9++z1nrpQRTJSpj5J1hpW7AE5ioChHufDbeQt0Pfjiyf4fak5hM/kV9sWNE=; __RequestVerificationToken=ANzGUHKyH3aUXdiCqZFhiDiNaLMRdHN2NFNcvEh8bsVk2yWji5jKU1KdvBv3qjekAlAzIBhirdsIqj6v0PCofvk1RXg1; TimeFormat=HH:mm; Culture=sv; DateFormat=DD.MM.YYYY; .AspNet.Auth=E-s5rF55pwsdNJiZc6uvPC6AX4fc3L8gr9HunlBwO0nh5ntPV3wI33YjeC6Z9-qWR2woMhnhMag13Tfq4KQuAkEgqDq-92i_ks3M1sxFWKd1JqGzyR0tQ-CbkH4UApSYHvAgHzUl2Gomv1XCTcNeMjei77eJa7qw0a1vvjlz_ZhpA6wqxjkI8DBXMEOuHnxflFcBbqwqFEYSAg0OrS3wBtC7KtKoAIILoRQttMH01Vs5eeoUWCxGxZ70wdPiaH9U6yQ6C0cEhAeS85RKypLOTdo4dP8o5vtR0sHS4nvts1QP6eTKSNi0AIDlm74gM8pN_M2vCo1QgfAcGjf7jOxGM2ZT06ilMhsnzZWc064ZYUar0oYUuospnThwHa9aC0oc4w36e8Y0U4mJmb3FL5yrea_TsFOBkRp76dIqgvP7MjKw_sVLcGXFZtbhehqPESd-V1jIW-96JsvCcFoxXZj4ujq_x6myAkQp2XTWPtbIJ8oV0EBIyAbWNce1i510vU7E3yhrqg; TS01329c72=015bdaa268eff3d3f02f191b846745f4539bd3abf67b79da5e8d5775dda369c9c842b94587312b1f763d2d877d69e347b91044367d; _gat_UA-77255390-2=1' \
#  --compressed \
#  --silent \
#  | jq

# Get current production
#PRODUCTION=$(curl -X GET 'http://oktorp.se:8000/solar_api/v1/GetInverterRealtimeData.cgi?Scope=Device&DeviceID=1&DataCollection=CommonInverterData' --silent | jq '.Body.Data.PAC.Value')
SITE=$(curl -X GET 'http://oktorp.se:8000/solar_api/v1/GetPowerFlowRealtimeData.fcgi' --silent | jq '.Body.Data.Site')

PRODUCTION=$(echo $SITE | jq '.P_PV')
CONSUMING=$(echo $SITE | jq '.P_Load')
BUYING=$(echo $SITE | jq '.P_Grid')
AUTONOMY=$(echo $SITE | jq '.rel_Autonomy')

#POWER=$(curl -X GET 'http://oktorp.se:8000/solar_api/v1/GetMeterRealtimeData.cgi?Scope=System' --silent | jq '.Body.Data')

# Power that house is using
#CONSUMPTION=$(echo $POWER | jq '."0".PowerApparent_S_Sum')
#BUYING=$(echo $POWER | jq '."0".PowerReal_P_Sum')

#echo $POWER | jq

#echo bc <<< $("$CONSUMPTION+$")

#echo "PRODUCING: $PRODUCTION"
#echo "CONSUMING: $CONSUMING"
#echo "BUYING: $BUYING"
#echo $(bc <<< "$BUYING+$PRODUCTION")

echo "{\"production\":$PRODUCTION, \"consumption\": $CONSUMING, \"buying\": $BUYING, \"autonomy\": $AUTONOMY}" | jq