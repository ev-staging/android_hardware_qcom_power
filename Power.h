/*
 * Copyright (C) 2017 The Android Open Source Project
 * Copyright (C) 2017-2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ANDROID_HARDWARE_POWER_POWER_QTI_H
#define ANDROID_HARDWARE_POWER_POWER_QTI_H

#ifdef USE_1_2_POWER
#include <android/hardware/power/1.2/IPower.h>
#else
#include <android/hardware/power/1.1/IPower.h>
#endif
#include <vendor/evervolv/power/1.0/IEvervolvPower.h>
#include <hidl/MQDescriptor.h>
#include <hidl/Status.h>
#include <hardware/power.h>

namespace android {
namespace hardware {
namespace power {
#ifdef USE_1_2_POWER
namespace V1_2 {
#else
namespace V1_1 {
#endif
namespace implementation {

using ::android::hardware::power::V1_0::Feature;
using PowerHint_1_0 = ::android::hardware::power::V1_0::PowerHint;
#ifdef USE_1_2_POWER
using PowerHint_1_2 = ::android::hardware::power::V1_2::PowerHint;
using ::android::hardware::power::V1_2::IPower;
#else
using ::android::hardware::power::V1_1::IPower;
#endif
using ::vendor::evervolv::power::V1_0::IEvervolvPower;
using ::vendor::evervolv::power::V1_0::EvervolvFeature;
using ::android::hardware::Return;
using ::android::hardware::Void;

struct Power : public IPower, public IEvervolvPower {
    // Methods from ::android::hardware::power::V1_0::IPower follow.

    Power();
    status_t registerAsSystemService();

    Return<void> setInteractive(bool interactive) override;
    Return<void> powerHint(PowerHint_1_0 hint, int32_t data) override;
    Return<void> setFeature(Feature feature, bool activate) override;
    Return<void> getPlatformLowPowerStats(getPlatformLowPowerStats_cb _hidl_cb) override;

    // Methods from ::android::hardware::power::V1_1::IPower follow.
    Return<void> getSubsystemLowPowerStats(getSubsystemLowPowerStats_cb _hidl_cb) override;
    Return<void> powerHintAsync(PowerHint_1_0 hint, int32_t data) override;
#ifdef USE_1_2_POWER
    // Methods from ::android::hardware::power::V1_2::IPower follow
    Return<void> powerHintAsync_1_2(PowerHint_1_2 hint, int32_t data) override;
#endif

    // Methods from ::vendor::evervolv::power::V1_0::IEvervolvPower follow.
    Return<int32_t> getFeature(EvervolvFeature feature) override;

    // Methods from ::android::hidl::base::V1_0::IBase follow.

};

}  // namespace implementation
}  // namespace V1_(1/2)
}  // namespace power
}  // namespace hardware
}  // namespace android

#endif  // ANDROID_HARDWARE_POWER_POWER_QTI_H
