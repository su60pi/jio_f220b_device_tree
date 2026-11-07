#!/bin/bash
#
# Extract proprietary blobs from ADB connected device
#

DEVICE=f220b
VENDOR=jio

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

DEVICE_IP="${1:-10.189.174.104:5555}"
echo "Extracting files from device: $DEVICE_IP"

while read -r FILE || [ -n "$FILE" ]; do
    # Skip comments and empty lines
    if [ -z "$FILE" ] || [[ "$FILE" =~ ^# ]]; then
        continue
    fi

    DIR=`dirname $FILE`
    mkdir -p $BASE/$DIR
    echo "Pulling /system/$FILE -> $BASE/$FILE"
    adb -s $DEVICE_IP pull /system/$FILE $BASE/$FILE 2>/dev/null || adb -s $DEVICE_IP pull /$FILE $BASE/$FILE
done < proprietary-files.txt

./setup-makefiles.sh
echo "Extraction completed successfully."
