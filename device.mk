#
# Copyright (C) 2026 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/jio/f220b

# Inherit from proprietary vendor blobs
$(call inherit-product-if-exists, vendor/jio/f220b/f220b-vendor.mk)

# Screen Resolution & Density (QVGA 240x320)
PRODUCT_AAPT_CONFIG := small normal
PRODUCT_AAPT_PREF_CONFIG := ldpi
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=120 \
    ro.sf.lcd_width=240 \
    ro.sf.lcd_height=320

# Audio Configurations
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(DEVICE_PATH)/configs/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(DEVICE_PATH)/configs/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    $(DEVICE_PATH)/configs/audio/mixer_paths_qrd_skuh.xml:system/etc/mixer_paths_qrd_skuh.xml \
    $(DEVICE_PATH)/configs/audio/mixer_paths_qrd_skui.xml:system/etc/mixer_paths_qrd_skui.xml

# Media Profiles & Codecs
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/media/media_profiles.xml:system/etc/media_profiles.xml \
    $(DEVICE_PATH)/configs/media/media_codecs.xml:system/etc/media_codecs.xml \
    $(DEVICE_PATH)/configs/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml

# Wi-Fi Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(DEVICE_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(DEVICE_PATH)/configs/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# Keylayout Files
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/keylayout/matrix_keypad.kl:system/usr/keylayout/matrix_keypad.kl \
    $(DEVICE_PATH)/configs/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(DEVICE_PATH)/configs/keylayout/qpnp_pon.kl:system/usr/keylayout/qpnp_pon.kl \
    $(DEVICE_PATH)/configs/keylayout/Generic.kl:system/usr/keylayout/Generic.kl

# Rootdir & Ramdisk Init Scripts
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/fstab.qcom:root/fstab.qcom \
    $(DEVICE_PATH)/rootdir/init.qcom.rc:root/init.qcom.rc \
    $(DEVICE_PATH)/rootdir/init.target.rc:root/init.target.rc \
    $(DEVICE_PATH)/rootdir/ueventd.qcom.rc:root/ueventd.qcom.rc \
    $(DEVICE_PATH)/rootdir/init.qcom.early_boot.sh:root/init.qcom.early_boot.sh

# Hardware HALs
PRODUCT_PACKAGES += \
    audio.primary.msm8909 \
    audio_policy.msm8909 \
    camera.msm8909 \
    lights.msm8909 \
    gralloc.msm8909 \
    hwcomposer.msm8909 \
    memtrack.msm8909 \
    power.msm8909

# Camera Service & Daemons
PRODUCT_PACKAGES += \
    mm-qcamera-daemon \
    libmmcamera_interface

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# System Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so \
    persist.radio.multisim.config=ssss \
    ro.telephony.default_network=9 \
    telephony.lteOnGsmDevice=1 \
    ro.camera.board=2 \
    ro.camera.front=0 \
    ro.camera.frontic=2560 \
    ro.camera.rear=4 \
    ro.camera.rearic=9482
