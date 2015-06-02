LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := UKM

LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES := data/UKM/UKM
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/init.d/

include $(BUILD_PREBUILT)
$(shell mkdir -p $(TARGET_OUT))
$(shell cp -a $(LOCAL_PATH)/data/UKM/ $(TARGET_OUT)/ )
