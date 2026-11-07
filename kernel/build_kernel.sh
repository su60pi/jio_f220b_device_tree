#!/bin/bash
#
# Automated Kernel Build Script for Jio Phone F220B (MSM8909)
#

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KERNEL_DIR="$DIR/kernel_msm8909"

echo "=== Jio Phone F220B Kernel Builder ==="

if [ ! -d "$KERNEL_DIR" ]; then
    echo "Cloning LineageOS MSM8909 3.10 kernel..."
    git clone --depth=1 https://github.com/LineageOS/android_kernel_qcom_msm8909.git -b cm-13.0 "$KERNEL_DIR"
fi

echo "Copying defconfig and device tree source..."
cp "$DIR/f220b_defconfig" "$KERNEL_DIR/arch/arm/configs/f220b_defconfig"
cp "$DIR/msm8909-f220b.dts" "$KERNEL_DIR/arch/arm/boot/dts/qcom/msm8909-f220b.dts"

cd "$KERNEL_DIR"

export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE="${CROSS_COMPILE:-arm-linux-androideabi-}"

echo "Configuring kernel with f220b_defconfig..."
make f220b_defconfig

echo "Compiling kernel zImage-dtb..."
make -j$(nproc) zImage-dtb

if [ -f "$KERNEL_DIR/arch/arm/boot/zImage-dtb" ]; then
    echo "SUCCESS: Kernel built at $KERNEL_DIR/arch/arm/boot/zImage-dtb"
    cp "$KERNEL_DIR/arch/arm/boot/zImage-dtb" "$DIR/zImage-dtb"
else
    echo "ERROR: zImage-dtb was not created."
    exit 1
fi
