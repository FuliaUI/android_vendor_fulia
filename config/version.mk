# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
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

FULIA_MOD_VERSION = 1.0
FULIA_BUILD_TYPE := UNOFFICIAL

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(FULIA_OFFICIAL), true)
   LIST = $(shell cat ota/devices/fulia.devices | awk '$$1 != "#" { print $$2 }')
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      FULIA_BUILD_TYPE := OFFICIAL

PRODUCT_PACKAGES += \
    Updater

    endif
    ifneq ($(IS_OFFICIAL), true)
       FULIA_BUILD_TYPE := UNOFFICIAL
       $(error Device is not official "$(CURRENT_DEVICE)")
    endif
endif

ifeq ($(FULIA_BETA),true)
    FULIA_VERSION := FuliaUI-$(FULIA_MOD_VERSION)-$(CURRENT_DEVICE)-$(FULIA_BUILD_TYPE)-$(shell date -u +%Y%m%d)-BETA
else
    FULIA_VERSION := FuliaUI-$(FULIA_MOD_VERSION)-$(CURRENT_DEVICE)-$(FULIA_BUILD_TYPE)-$(shell date -u +%Y%m%d)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.fulia.version=$(FULIA_VERSION) \
  ro.fulia.releasetype=$(FULIA_BUILD_TYPE) \
  ro.modversion=$(FULIA_MOD_VERSION)

FULIA_DISPLAY_VERSION := FuliaUI-$(FULIA_MOD_VERSION)-$(FULIA_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.fulia.display.version=$(FULIA_DISPLAY_VERSION)
