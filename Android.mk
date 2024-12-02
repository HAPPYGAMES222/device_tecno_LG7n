#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),LI7)

include $(call all-makefiles-under,$(LOCAL_PATH))

AUDIO_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/audio.primary.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT_VENDOR)/lib/hw/audio.r_submix.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT_VENDOR)/lib64/hw/audio.primary.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT_VENDOR)/lib64/hw/audio.r_submix.$(TARGET_BOARD_PLATFORM).so

$(AUDIO_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(subst $(TARGET_BOARD_PLATFORM),mediatek,$(notdir $@)) $@

CAMERA_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/, $(strip $(shell cat $(DEVICE_PATH)/symlink/camera.txt)))
$(CAMERA_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $(notdir $@)"
	@ln -sf $(TARGET_BOARD_PLATFORM)/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += \
	$(AUDIO_SYMLINKS) \
	$(CAMERA_SYMLINKS)

endif
