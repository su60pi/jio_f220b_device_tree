# Jio Phone F220B (Qualcomm MSM8909) - Kernel Tree

This directory contains the genuine, extracted kernel configuration and decompiled Device Tree Source (DTS) from the Stock Jio Phone F220B (KaiOS 2.5 / Android 6.0.1 base, Kernel 3.10.49).

---

## 1. Files in this Directory

- `f220b_defconfig`: The 100% genuine kernel `.config` pulled directly from `/proc/config.gz` of the working stock F220B device.
- `msm8909-f220b.dts`: Decompiled, complete Device Tree Source (313 KB) containing all hardware device nodes:
  - Display Panels: `holitech_gc9305_id_qvga_cmd`, `sanlong_gc9306_id_qvga_cmd`, `sanlong_st7789_id_qvga_cmd`, `visiontech_st7789`
  - Cameras: `sp250a` (SuperPix 2MP Rear), `sp0a09` (SuperPix VGA Front), `gc2385`, `gc2375`, `gc031a`, `gc034a`
  - Audio: Qualcomm WCD9306 codec / TFA98xx amplifier
  - Keypad: 4x5 Matrix keypad + GPIO keys
  - Modem & PMIC: MSM8909 / MSM8905 + PM8909 PMIC
- `msm8909-f220b.dtb`: The binary Flattened Device Tree extracted from the stock boot partition.
- `build_kernel.sh`: Shell script to clone CAF MSM8909 kernel source, apply configs, and build `zImage-dtb`.

---

## 2. Kernel Hardware Parameters

| Parameter | Value |
| :--- | :--- |
| **SoC** | Qualcomm Snapdragon 205 (MSM8905 / MSM8909) |
| **Architecture** | ARMv7-A (Cortex-A7 Dual Core) |
| **Kernel Version** | Linux 3.10.49 |
| **Board Base Address** | `0x80000000` |
| **Page Size** | `2048` bytes |
| **Kernel Offset** | `0x00008000` (`0x80008000`) |
| **Ramdisk Offset** | `0x01000000` (`0x81000000`) |
| **Tags Offset** | `0x00000100` (`0x80000100`) |
| **Command Line** | `console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk androidboot.selinux=permissive` |

---

## 3. How to Build the Kernel for Custom ROM

### Step 1: Clone Qualcomm MSM8909 Kernel Source
You can use the LineageOS 13.0 / Android 6.0 CAF kernel source for MSM8909:
```bash
git clone https://github.com/LineageOS/android_kernel_qcom_msm8909.git -b cm-13.0 kernel_msm8909
cd kernel_msm8909
```

### Step 2: Copy Device Tree & Defconfig
```bash
cp /path/to/f220b_defconfig arch/arm/configs/f220b_defconfig
cp /path/to/msm8909-f220b.dts arch/arm/boot/dts/qcom/msm8909-f220b.dts
```
Add the target to `arch/arm/boot/dts/qcom/Makefile`:
```makefile
dtb-$(CONFIG_ARCH_MSM8909) += msm8909-f220b.dtb
```

### Step 3: Compile with ARM GCC 4.8 / 4.9 Toolchain
```bash
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

make f220b_defconfig
make -j$(nproc) zImage-dtb
```

The resulting kernel with appended device tree will be generated at:
`arch/arm/boot/zImage-dtb`

### Step 4: Create boot.img
```bash
mkbootimg \
  --kernel arch/arm/boot/zImage-dtb \
  --ramdisk ramdisk.cpio.gz \
  --cmdline "console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk androidboot.selinux=permissive" \
  --base 0x80000000 \
  --pagesize 2048 \
  --ramdisk_offset 0x01000000 \
  --tags_offset 0x00000100 \
  -o boot.img
```
