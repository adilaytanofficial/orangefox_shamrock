LOCAL_PATH := device/google/shamrock

# PRODUCT_COPY_FILES += \
#     $(LOCAL_PATH)/recovery/root/sbin/adbd:recovery/root/sbin/adbd \
#     $(LOCAL_PATH)/recovery/root/sbin/parted:recovery/root/sbin/parted \
#     $(LOCAL_PATH)/recovery/root/sbin/qseecomd:recovery/root/sbin/qseecomd

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:recovery/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.qcom.rc:recovery/root/ueventd.qcom.rc \
    $(LOCAL_PATH)/recovery/root/sbin/reboot:recovery/root/sbin/reboot

PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1 \
    persist.sys.usb.config=mtp,adb