# Jio Phone F220B (LYF F220B) Device Tree

This repository contains the complete, production-ready Android / LineageOS device tree for **Jio Phone F220B** (`device/jio/f220b`), extracted directly from the genuine Stock KaiOS 2.5 (Android 6.0.1 Marshmallow base) device.

---

## Device Specifications

| Feature | Specification |
| :--- | :--- |
| **Model** | Jio Phone F220B (LYF F220B) |
| **SoC** | Qualcomm Snapdragon 205 (MSM8905 / MSM8909) |
| **CPU** | 2x ARM Cortex-A7 @ 1.1 GHz |
| **GPU** | Qualcomm Adreno 304 |
| **RAM** | 512 MB LPDDR3 |
| **Storage** | 4 GB eMMC 4.5 |
| **Display** | 2.4" QVGA (240x320) SPI TFT (GC9305 / GC9306 / ST7789) |
| **Rear Camera** | 2.0 MP SuperPix SP250A (0x250A / 9482) |
| **Front Camera** | 0.3 MP VGA SuperPix SP0A09 (0x0A09 / 2560) |
| **Audio** | Qualcomm WCD9306 Codec + TFA98xx Smart PA |
| **Keypad** | 4x5 Matrix Keypad + GPIO navigation keys |
| **Battery** | 2000 mAh Li-Ion |
| **Base OS** | Android 6.0.1 Marshmallow (API 23) |

---

## Directory Structure

```
device/jio/f220b/
├── Android.mk                 # Top-level makefile
├── AndroidProducts.mk         # Product target definition
├── full_f220b.mk              # Full AOSP / LineageOS product configuration
├── BoardConfig.mk             # Board architecture, partitions, and hardware flags
├── device.mk                  # Packages, copy-files, properties, permissions
├── fstab.qcom                 # Partition mount table for eMMC
├── system.prop                # Stock hardware system properties
├── proprietary-files.txt      # List of all required vendor blobs from stock
├── rootdir/                   # Ramdisk scripts & configs
│   ├── fstab.qcom
│   ├── init.qcom.rc
│   ├── init.target.rc
│   ├── init.qcom.early_boot.sh
│   └── ueventd.qcom.rc
└── configs/                   # Hardware configurations
    ├── audio/                 # mixer_paths, audio_policy, audio_platform_info
    ├── media/                 # media_profiles, media_codecs
    ├── wifi/                  # WCNSS_qcom_cfg.ini, wlan nvram, wpa_supplicant
    └── keylayout/             # matrix_keypad.kl, gpio-keys.kl, qpnp_pon.kl
```

---

## How to Build Custom ROM (LineageOS 13.0 / AOSP 6.0.1)

### 1. Place Device, Kernel & Vendor Trees in Source Tree
```bash
# In your LineageOS / AOSP 6.0 root directory:
git clone https://github.com/su60pi/jio_f220b_device_tree.git device/jio/f220b
git clone https://github.com/su60pi/jio_f220b_vendor_tree.git vendor/jio/f220b
```

### 2. Initialize Build Environment & Compile
```bash
source build/envsetup.sh
lunch full_f220b-userdebug
mka bacon -j$(nproc)
```

The compiled boot and system images will be located in:
`out/target/product/f220b/`
