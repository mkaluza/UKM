LOCAL_PATH := $(call my-dir)

LOCAL_MODULE := UKM

$(shell mkdir -p $(TARGET_OUT)/UKM )
$(shell mkdir -p $(TARGET_OUT)/etc/init.d )
$(shell cp -a $(LOCAL_PATH)/data/UKM/ $(TARGET_OUT)/ )
$(shell ln -fs /system/UKM/UKM $(TARGET_OUT_ETC)/init.d/99UKM)
$(shell ln -fs /data/UKM/uci $(TARGET_OUT)/xbin/uci)

