#!/bin/sh
hour=$(date +%H)
if [ "$hour" -lt 12 ]; then
    echo "morning(workout, diet) $(date +%H:%M)"
elif [ "$hour" -lt 17 ]; then
    echo "afternoon(work/study pomodoro sessions) $(date +%H:%M)"
else
    echo "evening(aesthetics, watchlist, cry in your bed alone) $(date +%H:%M)"
fi
