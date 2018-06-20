#!/bin/bash

#python populateimages.py
ADDIMAGE_OUTPUT=$(python addimageforprocessing.py)
echo "$ADDIMAGE_OUTPUT"

CONVERT_SIZE="200x200"

if ! [[ $ADDIMAGE_OUTPUT = *"Error"* ]]; then

	for file in ./algoinputimg/*; do
		convert $file -resize $CONVERT_SIZE $file;
		echo "Converted: $file";
		algo cp ./algoinputimg/* data://sendmegarbage/algoinputimg/;
	done;

	for file in ./algostyleimg/*; do
		convert $file -resize $CONVERT_SIZE $file;
		echo "Converted: $file";
		algo cp ./algostyleimg/* data://sendmegarbage/algostyleimg/;
	done;
	
	# Execute main
	#bash executeneural.sh;
	echo "Executing main script";

	# Perform cleanup

else
	echo "Images not moved to flightdeck from add image error";
fi

# Execute main

if [ ! -z "$(ls -A ./algoinputimg/)" ] && [ ! -z "$(ls -A ./algostyleimg/)" ]; then
   	# Execute main
	#bash executeneural.sh;
	echo "Executing main script";

	# Clean up
	INPUT_FILE_NAME="$(find ./algoinputimg/ -type f -printf "%f")"
	STYLE_FILE_NAME="$(find ./algostyleimg/ -type f -printf "%f")"

	rm ./algoinputimg/$INPUT_FILE_NAME
	rm ./algostyleimg/$STYLE_FILE_NAME

else
	echo "Algo input directories are incomplete"
fi
