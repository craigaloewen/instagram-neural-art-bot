#!/bin/bash

INPUT_FILE_NAME="$(find ./algooutputimg/ -type f -printf "%f")"

# Post output to instagram

# If image is still in output verify that it isn't posted to instagram first

cleanup () {
	echo "Image is posted to instagram! Starting cleanup";
	
	# If it was uploaded then move it
	mv ./algooutputimg/$INPUT_FILE_NAME ./outputimg/$INPUT_FILE_NAME;
	rm ./algostyle/img/*

	python finishuploadcleanup.py 

	echo "Program success! Now exiting";

}


IMAGEPOSTED_OUTPUT=$(python verifyuploadedimage.py)
echo "$IMAGEPOSTED_OUTPUT"

if [[ $IMAGEPOSTED_OUTPUT = *"SUCCESS"* ]]; then
	
	cleanup

elif [[ $IMAGEPOSTED_OUTPUT = *"FAILURE"* ]]; then
	echo "Image is not posted to instagram. Attempting to post now.";
	
	POSTIMAGE_OUTPUT=$(python instaposter.py)
	echo "$POSTIMAGE_OUTPUT"

	echo "Attempt to post to instagram done. Waiting for 10 minutes and then attempting to verify again";

	sleep 10m;

	IMAGEPOSTED_OUTPUT=$(python verifyuploadedimage.py);
	echo "$IMAGEPOSTED_OUTPUT";

	if [[ $IMAGEPOSTED_OUTPUT = *"SUCCESS"* ]]; then

		cleanup

	else
		echo "Image not posted to instagram on 2nd attempt. Exiting."

	fi

else
	echo "Error state encountered! Doing nothing!"
fi
