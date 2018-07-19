#!/bin/bash

if [ -z "$(ls -A ./algoinputimg/)" ]; then
	
	echo "Input image directory is empty"

	python populateimages.py
	ADDIMAGE_OUTPUT=$(python addimageforprocessing.py)
	echo "$ADDIMAGE_OUTPUT"

	CONVERT_SIZE="400x400"

	if ! [[ $ADDIMAGE_OUTPUT = *"Error"* ]]; then

		for file in ./algoinputimg/*; do
			convert $file -resize $CONVERT_SIZE $file;
			echo "Converted: $file";
		done;

		for file in ./algostyleimg/*; do
			convert $file -resize $CONVERT_SIZE $file;
			echo "Converted: $file";
		done;
		
	else
		echo "Images not moved to flightdeck from add image error";
	fi

else
	echo "Image input directories already have contents"
fi



# Execute main

if [ ! -z "$(ls -A ./algoinputimg/)" ] && [ ! -z "$(ls -A ./algostyleimg/)" ]; then
   	# Execute main
	echo "Executing main script";
	NEURALBASH_OUTPUT=$(bash executeneural.sh)
	echo "$NEURALBASH_OUTPUT";

	if ! [[ $NEURALBASH_OUTPUT = *"error"* ]]; then
		
		echo "No errors detected";

		# Clean up
		INPUT_FILE_NAME="$(find ./algoinputimg/ -type f -printf "%f")";
		STYLE_FILE_NAME="$(find ./algostyleimg/ -type f -printf "%f")";

		rm ./algoinputimg/$INPUT_FILE_NAME;

		algo cp data://.algo/bkyan/StyleThief/temp/default_output.jpg ./algooutputimg/$INPUT_FILE_NAME

		algo cp ./algooutputimg/* "data://sendmegarbage/algooutputimg/" 

	else
		echo "Script execution error";
	fi

else
	echo "Algo input directories are incomplete"
fi
