#!/bin/bash

# This script downloads covid data and displays it

DATA=$(curl https://api.covidtracking.com/v1/us/current.json)
POSITIVE=$(echo $DATA | jq '.[0].positive')
HOSPITALCURRENT=$(echo $DATA | jq '.[0].hospitalizedCurrently')
ICUCURRENT=$(echo $DATA | jq '.[0].inIcuCurrently')
VENTILATORCURRENT=$(echo $DATA | jq '.[0].onVentilatorCurrently')
TODAY=$(date)

echo "On $TODAY, there were $POSITIVE positive COVID cases. There are currently $HOSPITALCURRENT in the hospital. Of these patients, $ICUCURRENT are in the ICU, and $VENTILATORCURRENT are on ventilators."
