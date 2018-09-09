# Copyright (C) 2017 The Android Open Source Project
# Copyright (C) 2017-2018 The LineageOS Project
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

ifeq ($(call my-dir),$(call project-path-for,qcom-power))

LOCAL_PATH := $(call my-dir)

ifeq ($(call is-vendor-board-platform,QCOM),true)

qcom_power_src_files :=
qcom_power_cflags :=
qcom_power_c_includes :=
qcom_power_header_libs :=
qcom_power_shared_libs :=
qcom_power_static_libs :=
qcom_power_whole_static_libs :=

qcom_power_shared_libs += \
    android.hardware.power@1.0 \
    android.hardware.power@1.1 \
    liblog \
    libcutils \
    libdl \
    libxml2 \
    libhidlbase \
    libhidltransport \
    libhardware \
    libhwbinder \
    libutils \
    vendor.evervolv.power@1.0

qcom_power_src_files += \
    service.cpp \
    Power.cpp \
    power-helper.c \
    metadata-parser.c \
    utils.c \
    list.c \
    hint-data.c

qcom_power_header_libs += libutils_headers libhardware_headers
qcom_power_c_includes += external/libxml2/include \
                    external/icu/icu4c/source/common

qcom_power_cflags := -Wall -Wextra -Werror

ifneq ($(BOARD_POWER_CUSTOM_BOARD_LIB),)
    qcom_power_whole_static_libs += $(BOARD_POWER_CUSTOM_BOARD_LIB)
else

# Include target-specific files.
ifeq ($(call is-board-platform-in-list, msm8960), true)
qcom_power_src_files += power-8960.c
endif

ifeq ($(call is-board-platform-in-list, msm8974), true)
qcom_power_src_files += power-8974.c
endif

ifeq ($(call is-board-platform-in-list, msm8226), true)
qcom_power_src_files += power-8226.c
endif

ifeq ($(call is-board-platform-in-list, msm8610), true)
qcom_power_src_files += power-8610.c
endif

ifeq ($(call is-board-platform-in-list, apq8084), true)
qcom_power_src_files += power-8084.c
endif

ifeq ($(call is-board-platform-in-list, msm8994), true)
qcom_power_src_files += power-8994.c
endif

ifeq ($(call is-board-platform-in-list, msm8992), true)
qcom_power_src_files += power-8992.c
endif

ifeq ($(call is-board-platform-in-list, msm8996), true)
qcom_power_src_files += power-8996.c
endif

ifeq ($(call is-board-platform-in-list,msm8937), true)
qcom_power_src_files += power-8937.c
endif

ifeq ($(call is-board-platform-in-list,msm8952), true)
qcom_power_src_files += power-8952.c
endif

ifeq ($(call is-board-platform-in-list,msm8953), true)
qcom_power_src_files += power-8953.c
endif

ifeq ($(call is-board-platform-in-list,msm8998 apq8098_latv), true)
qcom_power_src_files += power-8998.c
endif

ifeq ($(call is-board-platform-in-list,sdm660), true)
qcom_power_src_files += power-660.c
endif

ifeq ($(call is-board-platform-in-list,sdm845), true)
qcom_power_src_files += power-845.c
endif

ifeq ($(call is-board-platform-in-list,sdm710), true)
qcom_power_src_files += power-710.c
endif

ifeq ($(call is-board-platform-in-list,qcs605), true)
qcom_power_src_files += power-710.c
endif

ifeq ($(call is-board-platform-in-list,trinket), true)
qcom_power_src_files += power-6125.c
endif

ifeq ($(call is-board-platform-in-list,msmnile), true)
qcom_power_src_files += power-msmnile.c
endif

ifeq ($(call is-board-platform-in-list, msm8909), true)
qcom_power_src_files += power-8909.c
endif

ifeq ($(call is-board-platform-in-list,msm8916), true)
qcom_power_src_files += power-8916.c
endif

endif  #  End of board specific list

ifneq ($(TARGET_POWER_SET_FEATURE_LIB),)
    qcom_power_static_libs += $(TARGET_POWER_SET_FEATURE_LIB)
endif

ifeq ($(TARGET_USES_INTERACTION_BOOST),true)
    qcom_power_cflags += -DINTERACTION_BOOST
endif

ifneq ($(TARGET_POWERHAL_SET_INTERACTIVE_EXT),)
qcom_power_cflags += -DSET_INTERACTIVE_EXT
qcom_power_src_files += ../../../$(TARGET_POWERHAL_SET_INTERACTIVE_EXT)
endif

ifneq ($(TARGET_TAP_TO_WAKE_NODE),)
    qcom_power_cflags += -DTAP_TO_WAKE_NODE=\"$(TARGET_TAP_TO_WAKE_NODE)\"
endif

ifeq ($(TARGET_HAS_LEGACY_POWER_STATS),true)
    qcom_power_cflags += -DLEGACY_STATS
endif

ifeq ($(TARGET_HAS_NO_POWER_STATS),true)
    qcom_power_cflags += -DNO_STATS
endif

ifneq ($(TARGET_RPM_STAT),)
    qcom_power_cflags += -DRPM_STAT=\"$(TARGET_RPM_STAT)\"
endif

ifneq ($(TARGET_RPM_MASTER_STAT),)
    qcom_power_cflags += -DRPM_MASTER_STAT=\"$(TARGET_RPM_MASTER_STAT)\"
endif

ifneq ($(TARGET_RPM_SYSTEM_STAT),)
    qcom_power_cflags += -DRPM_SYSTEM_STAT=\"$(TARGET_RPM_SYSTEM_STAT)\"
endif

ifneq ($(TARGET_WLAN_POWER_STAT),)
    qcom_power_cflags += -DWLAN_POWER_STAT=\"$(TARGET_WLAN_POWER_STAT)\"
endif

ifeq ($(TARGET_HAS_NO_WLAN_STATS),true)
qcom_power_cflags += -DNO_WLAN_STATS
endif

ifeq ($(TARGET_ARCH),arm)
qcom_power_cflags += -DARCH_ARM_32
endif

# Version 1.1
include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(qcom_power_src_files)
LOCAL_C_INCLUDES := $(qcom_power_c_includes)
LOCAL_CFLAGS := $(qcom_power_cflags)
LOCAL_HEADER_LIBRARIES := $(qcom_power_header_libs)
LOCAL_SHARED_LIBRARIES := $(qcom_power_shared_libs)
LOCAL_STATIC_LIBRARIES := $(qcom_power_static_libs)
LOCAL_WHOLE_STATIC_LIBRARIES := $(qcom_power_whole_static_libs)
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE := android.hardware.power@1.1-service-qti
LOCAL_INIT_RC := android.hardware.power@1.1-service-qti.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := qcom
LOCAL_VENDOR_MODULE := true

include $(BUILD_EXECUTABLE)

# Version 1.2
include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(qcom_power_src_files)
LOCAL_C_INCLUDES := $(qcom_power_c_includes)
LOCAL_CFLAGS := $(qcom_power_cflags) -DUSE_1_2_POWER
LOCAL_HEADER_LIBRARIES := $(qcom_power_header_libs)
LOCAL_SHARED_LIBRARIES := $(qcom_power_shared_libs) android.hardware.power@1.2
LOCAL_STATIC_LIBRARIES := $(qcom_power_static_libs)
LOCAL_WHOLE_STATIC_LIBRARIES := $(qcom_power_whole_static_libs)
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE := android.hardware.power@1.2-service-qti
LOCAL_INIT_RC := android.hardware.power@1.2-service-qti.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := qcom
LOCAL_VENDOR_MODULE := true

include $(BUILD_EXECUTABLE)

endif

endif
