#!/bin/bash

DATETIME="$(date +'%Y-%m-%d_%H%M%S')"
RESOLUTION="1200"
SAVE_FORMAT="tiff"
SAVE_PATH="~/tammy/scans"

# clear SCANNER_ADDR if we pass clear as arg1
if [ "$1" = "clear" ]; then
	unset SCANNER_ADDR
fi

# if we find SCANNER_ADDR in env, go through
if [ -z "$SCANNER_ADDR" ]; then
	SCANNER_ADDR="$(scanimage -L | awk 'NR=2 {print $2}' | grep genesys)"
	SCANNER_ADDR=${SCANNER_ADDR//\`}
	SCANNER_ADDR=${SCANNER_ADDR//\'}
	export SCANNER_ADDR
fi

FILEPATH="$SAVE_PATH/${DATETIME}_${RESOLUTION}.$SAVE_FORMAT"
CMD="scanimage --device \"$SCANNER_ADDR\" --resolution=$RESOLUTION --progress --buffer-size --mode=color --format=$SAVE_FORMAT > $FILEPATH"

eval $CMD
echo "scanned: $FILEPATH"

