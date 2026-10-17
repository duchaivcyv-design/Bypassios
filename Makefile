TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TOOL_NAME = AbsoluteBreakMasterV2Ultimate

AbsoluteBreakMasterV2Ultimate_FILES = src/main.mm
AbsoluteBreakMasterV2Ultimate_CFLAGS = -fobjc-arc -Wall -Wextra -Isrc
AbsoluteBreakMasterV2Ultimate_FRAMEWORKS = UIKit Foundation CoreGraphics
AbsoluteBreakMasterV2Ultimate_CODESIGN_FLAGS = -SAbsoluteBreakV2.entitlements

include $(THEOS_MAKE_PATH)/tool.mk

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakV2Ultimate.app
	cp $(THEOS_OBJ_DIR)/AbsoluteBreakMasterV2Ultimate $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakV2Ultimate.app/AbsoluteBreakMasterV2Ultimate
	cp layout/Applications/AbsoluteBreakV2Ultimate.app/Info.plist $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakV2Ultimate.app/Info.plist
