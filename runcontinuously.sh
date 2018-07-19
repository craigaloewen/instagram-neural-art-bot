#!/bin/bash

while true; do

	bash main.sh;
	next_run_date=$(date -d '+12 hour' '+%F %T');
	current_time=$(date '+%F %T');
	echo "Current datetime: $current_time";
	echo "Next running script on: $next_run_date";
	sleep 24h;
done
