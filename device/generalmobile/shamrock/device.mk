LOCAL_PATH := device/generalmobile/shamrock

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:recovery/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.qcom.rc:recovery/root/ueventd.qcom.rc \
    $(LOCAL_PATH)/recovery/root/sbin/reboot:recovery/root/sbin/reboot \
    $(LOCAL_PATH)/recovery/root/sbin/usb_led_monitor:recovery/root/sbin/usb_led_monitor \
    $(LOCAL_PATH)/recovery/root/sbin/adbd:recovery/root/sbin/adbd

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/theme/theme_install.sh:recovery/root/FFiles/OF_default_theme/theme_install.sh \
    $(LOCAL_PATH)/recovery/root/theme/theme/accent.xml:recovery/root/FFiles/OF_default_theme/theme/accent.xml \
    $(LOCAL_PATH)/recovery/root/theme/theme/style.xml:recovery/root/FFiles/OF_default_theme/theme/style.xml \
    $(LOCAL_PATH)/recovery/root/theme/theme/foxs:recovery/root/FFiles/OF_default_theme/theme/foxs

PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1 \
    persist.sys.usb.config=adb

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/dtb.img:dtb.img