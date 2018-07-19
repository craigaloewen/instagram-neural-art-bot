#!/bin/bash

if [ -z "$(ls -A ./algooutputimg/)" ]; then

	echo "No output image detected proceeding with loading images";
	
	bash loadimgandexecute.sh;

	if [ ! -z "$(ls -A ./algooutputimg/)" ]; then

		bash uploadtoinsta.sh;
	else
		echo "Error: After executing main image processing, no output img detected";
	fi

else
	echo "Unuploaded output image detected attempting to upload again";

	bash uploadtoinsta.sh;

fi

