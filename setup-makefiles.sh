#!/bin/bash
#
# Generate vendor makefiles from extracted proprietary files
#

DEVICE=f220b
VENDOR=jio

OUTDIR=../../../vendor/$VENDOR/$DEVICE
MAKEFILE=$OUTDIR/$DEVICE-vendor.mk
ANDROIDMK=$OUTDIR/Android.mk

mkdir -p $OUTDIR

# Create f220b-vendor.mk
cat << EOF > $MAKEFILE
#
# Proprietary blob definitions for Jio Phone F220B
#

PRODUCT_COPY_FILES += \\
EOF

while read -r FILE || [ -n "$FILE" ]; do
    if [ -z "$FILE" ] || [[ "$FILE" =~ ^# ]]; then
        continue
    fi
    echo "    vendor/$VENDOR/$DEVICE/proprietary/$FILE:system/$FILE \\" >> $MAKEFILE
done < proprietary-files.txt

# Remove trailing slash from last item
sed -i '$ s/ \\$//' $MAKEFILE

# Create Android.mk
cat << EOF > $ANDROIDMK
#
# Android.mk for vendor/$VENDOR/$DEVICE
#

LOCAL_PATH := \$(call my-dir)

ifeq (\$(TARGET_DEVICE),$DEVICE)

include \$(CLEAR_VARS)
LOCAL_MODULE := libmmcamera_interface
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/lib/libmmcamera_interface.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := \$(TARGET_OUT_SHARED_LIBRARIES)
include \$(BUILD_PREBUILT)

endif
EOF

chmod +x extract-files.sh setup-makefiles.sh
echo "Generated $MAKEFILE and $ANDROIDMK successfully."
