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

#ifndef ANDROID_HARDWARE_POWER_V1_1_POWER_H
#define ANDROID_HARDWARE_POWER_V1_1_POWER_H

#include <android/hardware/power/1.1/IPower.h>
#ifdef PERF_PROFILES
#include <vendor/lineage/power/1.0/ILineagePower.h>
#endif
#include <hidl/MQDescriptor.h>
#include <hidl/Status.h>
#include <hardware/power.h>

namespace android {
namespace hardware {
namespace power {
namespace V1_1 {
namespace implementation {

using ::android::hardware::power::V1_0::Feature;
using ::android::hardware::power::V1_0::PowerHint;
using ::android::hardware::power::V1_1::IPower;
#ifdef PERF_PROFILES
using ::vendor::lineage::power::V1_0::ILineagePower;
using ::vendor::lineage::power::V1_0::LineageFeature;
#endif
using ::android::hardware::Return;
using ::android::hardware::Void;

#ifdef PERF_PROFILES
struct Power : public IPower, public ILineagePower
#else
struct Power : public IPower
#endif
{
    // Methods from ::android::hardware::power::V1_0::IPower follow.

    Power();
    status_t registerAsSystemService();

    Return<void> setInteractive(bool interactive) override;
    Return<void> powerHint(PowerHint hint, int32_t data) override;
    Return<void> setFeature(Feature feature, bool activate) override;
    Return<void> getPlatformLowPowerStats(getPlatformLowPowerStats_cb _hidl_cb) override;

    // Methods from ::android::hardware::power::V1_1::IPower follow.
    Return<void> getSubsystemLowPowerStats(getSubsystemLowPowerStats_cb _hidl_cb) override;
    Return<void> powerHintAsync(PowerHint hint, int32_t data) override;

#ifdef PERF_PROFILES
    // Methods from ::vendor::lineage::power::V1_0::ILineagePower follow.
    Return<int32_t> getFeature(LineageFeature feature) override;
#endif

    // Methods from ::android::hidl::base::V1_0::IBase follow.

};

}  // namespace implementation
}  // namespace V1_0/1
}  // namespace power
}  // namespace hardware
}  // namespace android

#endif  // ANDROID_HARDWARE_POWER_V1_1_POWER_H
