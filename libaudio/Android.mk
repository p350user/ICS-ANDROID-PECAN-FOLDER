# Copyright 2012 The Android Open Source Project

#AUDIO_POLICY_TEST := true
#ENABLE_AUDIO_DUMP := true

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    LOCAL_CFLAGS += -DQCOM_HARDWARE
endif


LOCAL_SRC_FILES := \
    AudioHardware.cpp \
    audio_hw_hal.cpp


ifeq ($(BOARD_HAVE_BLUETOOTH),true)
    LOCAL_CFLAGS += -DWITH_A2DP
endif

ifeq ($(BOARD_USES_QCOM_AUDIO_SPEECH),true)
    LOCAL_CFLAGS += -DWITH_QCOM_SPEECH
endif

LOCAL_SHARED_LIBRARIES := \
    libcutils       \
    libutils        \
    libmedia

ifneq ($(TARGET_SIMULATOR),true)
    LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper  \
    libaudiohw_legacy

LOCAL_MODULE := audio.primary.p350
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS += -fno-short-enums

LOCAL_C_INCLUDES := $(TARGET_OUT_HEADERS)/mm-audio/audio-alsa
#LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audcal
LOCAL_C_INCLUDES += hardware/libhardware/include
LOCAL_C_INCLUDES += hardware/libhardware_legacy/include
LOCAL_C_INCLUDES += frameworks/base/include
LOCAL_C_INCLUDES += system/core/include

include $(BUILD_SHARED_LIBRARY)


# The audio policy is implemented on top of legacy policy code
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    AudioPolicyManager.cpp \
    audio_policy_hal.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libmedia

LOCAL_STATIC_LIBRARIES := \
    libaudiopolicy_legacy \
    libmedia_helper

LOCAL_MODULE := audio_policy.p350
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
    LOCAL_CFLAGS += -DWITH_A2DP
endif

LOCAL_C_INCLUDES := hardware/libhardware_legacy/audio


include $(BUILD_SHARED_LIBRARY)
