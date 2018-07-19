#!/bin/bash -e

im="$1"
targetaspect="$2"

read W H <<< $(identify -ping -format "%w %h" "$im")
curaspect=$(bc <<< "scale=10; $W / $H")

echo "current-aspect: $curaspect; target-aspect: $targetaspect"

comparison=$(bc <<< "$curaspect > $targetaspect")
if [[ "$comparison" = "1" ]]; then
	targeth=$(bc <<< "scale=10; $W / $targetaspect")
	targetextent="${W}x${targeth%.*}"
else
        targetw=$(bc <<< "scale=10; $H * $targetaspect")
	targetextent="${targetw%.*}x$H"
fi

echo "Converting image to ratio $2"

convert "$im" -background black \
	    -gravity center -extent "$targetextent" \
		$1
