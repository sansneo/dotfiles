#!/bin/sh
hour=$(date +%H)
if [ "$hour" -lt 12 ]; then
    echo "morning() $(date +%H:%M)"
elif [ "$hour" -lt 17 ]; then
    echo "afternoon() $(date +%H:%M)"
else
    echo "evening() $(date +%H:%M)"
fi
