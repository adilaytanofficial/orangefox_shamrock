LOCAL_PATH := device/generalmobile/shamrock

$(call inherit-product, device/generalmobile/shamrock/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

PRODUCT_DEVICE := shamrock
PRODUCT_NAME := fox_shamrock
PRODUCT_BRAND := GeneralMobile
PRODUCT_MODEL := GM 5 Plus
PRODUCT_MANUFACTURER := General Mobile

# TWRP Settings
TW_INCLUDE_CRYPTO := false
TWRP_INCLUDE_LOGCAT := true
TW_EXTRA_LANGUAGES := true
TW_HAS_EDL_MODE := true
TW_USE_TOOLBOX := true
TW_THEME := portrait_hdpi
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS := true
TW_INCLUDE_NTFS_3G := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_EXCLUDE_TWRPAPP := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_HAS_NO_REAL_SDCARD := true
TW_INPUT_BLACK_LIST := /dev/input/event1
TW_INCLUDE_MTP := 1

# Maintainer Info
OF_MAINTAINER := Nobugger
FOX_DEVICE := shamrock
FOX_BUILD_TYPE := Unofficial
FOX_INTERNAL_RELEASE := R12.1
FOX_MANIFEST_VER := 12.1
FOX_OUT_NAME := OrangeFox-R12.1-Unofficial-shamrock

# UI Settings
OF_SCREEN_H := 1920
OF_STATUS_BAR_HEIGHT := 60
OF_NAV_H := 90
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 2
OF_USE_LOCKSCREEN_BUTTON := 1
OF_USE_LEGACY_BATTERY_SERVICES := 1

# Shell & Core Tools
FOX_ALLOW_EARLY_SETTINGS_LOAD := 1
FOX_BUILD_DEBUG_MESSAGES := 0
FOX_DELETE_AROMAFM := 1
FOX_DELETE_INITD_ADDON := 1
OF_USE_MAGISKBOOT := 1
OF_INCLUDE_MAGISK := 1
FOX_VANILLA_BUILD := 1
OF_RUN_POST_FORMAT_PROCESS := 1
OF_PATCH_AVB20 := 1