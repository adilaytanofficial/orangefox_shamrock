LOCAL_PATH := device/google/shamrock

# Platform
TARGET_BOARD_PLATFORM := msm8952
TARGET_BOOTLOADER_BOARD_NAME := MSM8952
TARGET_NO_BOOTLOADER := false
TARGET_OTA_ASSERT_DEVICE := shamrock,GM5Plus,GM5_Plus,gm5plus

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_CPU_CORTEX_A53 := true
TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true

# Charger & Backlight
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BACKLIGHT_PATH := /sys/class/leds/lcd-backlight/brightness

# Crypto & Encryption Control
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FKEY := true
TARGET_HW_DISK_ENCRYPTION := false
TW_LEGACY_DECRYPT := true

# Kernel & Boot Image Parametreleri
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_OFFSET := 0x00008000

BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk buildvariant=userdebug
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
TW_ALWAYS_PERMISSIVE := true
#BOARD_KERNEL_CMDLINE += androidboot.reboot_reason=recovery
#BOARD_KERNEL_CMDLINE += androidboot.mode=recovery

# Prebuilt Kernel & DTB
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/prebuilt/kernel
BOARD_KERNEL_SEPARATED_DT := false

# Mkbootimg Argümanları
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version 0

BOARD_INCLUDE_DTB_IN_BOOTIMG := false
TARGET_NEEDS_DTB := false
BOARD_PREBUILT_DTBIMAGE := $(LOCAL_PATH)/prebuilt/dtb.img

# Sideload ve USB Bağlantı Tespiti (Qualcomm MSM8952 Fix)
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/msm_hsusb/gadget/lun%d/file"
TW_HAS_MTP := true

# Filesystem & Partition Sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221452800
BOARD_USERDATAIMAGE_PARTITION_SIZE := 24792731648
BOARD_VENDORIMAGE_PARTITION_SIZE := 524083200

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USES_MKE2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072

# Legacy Partition Non-Treble Fix
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := false
PRODUCT_FULL_TREBLE_OVERRIDE := false
TARGET_COPY_OUT_VENDOR := vendor
BOARD_USES_VENDORIMAGE := true

# Display Configuration
TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920
RECOVERY_GRAPHICS_USE_HEADER_SCALING := true

# ADB & Security
ALLOW_MISSING_DEPENDENCIES := true
ALLOW_ADBD_DISABLE_VERIFICATION := true
PERSISTENT_ADB := true
TARGET_USES_LOGD := false
BOARD_AVB_ENABLE := false

# Root ADB Ayarları (ADB'nin offline düşmesini engeller)
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1 \
    persist.sys.usb.config=mtp,adb

# OrangeFox & Build System Optimizations
FOX_ARCH := arm64
PLATFORM_SECURITY_PATCH := 2021-06-05
PLATFORM_VERSION := 10.0.0

OF_DISABLE_MIUI_SPECIFIC_SUPPORTS := 1
OF_QUICK_BACKUP_LIST := /boot;/data;/system;/vendor;

# Custom Vendor & Recovery Props
TARGET_RECOVERY_DEVICE_DIRS += device/google/shamrock
TARGET_PROP := device/google/shamrock/prop.default

BUILD_WITH_COLORS := true

# Qualcomm legacy cihazlar için FunctionFS ve USB Çakışma Önleme
TARGET_RECOVERY_UNKNOWN_PARENTS := true
TW_EXCLUDE_DEFAULTUSB_INIT := true
TW_EXCLUDE_DEFAULT_USB_INIT := true

# ADB / USB FunctionFS tanımları
GLOBAL_CFLAGS += -DALLOW_DISABLE_SELINUX=1

PRODUCT_BUILD_LICENSE_METADATA := false

# ====================================================================
# Reboot & Recovery Action Fix (Qualcomm MSM8952 / Shamrock)
# ====================================================================
BOARD_RECOVERY_BLDRMSG_OFFSET := 0
TARGET_RECOVERY_QCOM_RTC_FIX := true

# Reboot Butonları Düzeltmesi (Bootloader Menüsünü Aktif Eder)
TW_NO_REBOOT_BOOTLOADER := false
TW_NO_REBOOT_RECOVERY := false
TW_HAS_DOWNLOAD_MODE := false

# Executable, Shell & Resetprop Yetki Tanımları
TW_INCLUDE_LIBRESETPROP := true
TW_USE_TOOLBOX := true
RECOVERY_BINARY_SOURCE := 67

# Storage Configuration
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true

# Zip / Binary ve Bootloader kütüphaneleri
TARGET_RECOVERY_DEVICE_MODULES += timestamp
TARGET_RECOVERY_UPDATER_LIBS += libcutils libselinux libbootloader_message

# OrangeFox / TWRP /misc Otomatik Temizleme
TW_CLEAN_BOOTLOADER_MESSAGE := true
TARGET_RECOVERY_DEVICE_HAVE_MISC_PARTITION := true
TW_TARGET_MISC_PATH := /dev/block/bootdevice/by-name/misc

# TORCH
OF_FLASHLIGHT_ENABLE := 1
OF_FL_PATH1 := /sys/class/leds/led:torch_0
OF_FL_PATH2 := /sys/class/leds/led:switch
OF_MAX_BRIGHTNESS := 120

TARGET_RECOVERY_DEVICE_MODULES += \
    lights.msm8952 \
    android.hardware.light@2.0-service

# OrangeFox SAR ve Partition Tanımları (EKLENMELİ)
OF_USE_GREEN_FIX := true
OF_SYSTEM_AS_ROOT := true
OF_STATUS_INDENT := 0
TW_HAS_SYSTEM_ROOT := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
OF_USE_MAGISKBOOT_FOR_ALL_PATCHES := 1
OF_DISABLE_MIUI_SPECIFIC_FEATURES := 1
OF_HAS_SYSTEM_ROOT := 1