#!/bin/bash

# a fn that explains our usage
usage() { echo "Usage: $0 [-r <300|600|1200>] [-p </path/to>] [-f <tiff|png|jpg>]" 1>&2; exit 1;}

# parse our params
while getopts ":r:p:f:" o; do
    case "${o}" in
        r)
            # ((r == 300 || r == 600 || r == 1200)) || usage
            RESOLUTION=${OPTARG}
            ;;
        p)
            SAVE_PATH=${OPTARG}
            ;;
        f)
            # (("$r" == "tiff" || "$r" == "png" || "$r" == "jpg")) || usage
            SAVE_FORMAT=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# make sure we have all params
# if [ -z "${r}" ] || [ -z "${p}" ] || [ -z "${f}" ]; then
#    usage
# fi

DATETIME="$(date +'%Y-%m-%d_%H%M%S')"

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

