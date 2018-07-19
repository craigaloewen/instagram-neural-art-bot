#!/bin/bash

INPUT_FILE_NAME="$(find ./algoinputimg/ -type f -printf "%f")"
STYLE_FILE_NAME="$(find ./algostyleimg/ -type f -printf "%f")"

INPUT_FILE_DIR="data://sendmegarbage/algoinputimg/$INPUT_FILE_NAME"
STYLE_FILE_DIR="data://sendmegarbage/algostyleimg/$STYLE_FILE_NAME"

OUTPUT_FILE_DIR="data://sendmegarbage/algooutputimg/$INPUT_FILENAME"

algo cp ./algoinputimg/* $INPUT_FILE_DIR
algo cp ./algostyleimg/* $STYLE_FILE_DIR

curl -X POST -d '{
	"source" : "'$INPUT_FILE_DIR'",
	"style" : "'$STYLE_FILE_DIR'",
	"output" : "default_output.jpg",
	"iterations" : 800,
	"style_layer_weight_exp" : 1,
	"content_weight_blend" : 1,
	"initial_image" : 0,
	"pooling" : "max",
	"preserve_colors" : 0,
	"style_weight" : 500,
	"content_weight" : 5,
	"tv_weight" : 100,
	"learning_rate" : 10,
	"log_channel" : "",
	"log_interval" : 25
}
' -H 'Content-Type: application/json' -H 'Authorization: Simple simlicR5aRgqx6+kmF+1J6BHJra1' https://api.algorithmia.com/v1/algo/bkyan/StyleThief/0.2.13

