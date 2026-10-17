TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TOOL_NAME = AbsoluteBreakMasterV2

AbsoluteBreakMasterV2_FILES = src/main.mm src/hook_core.mm
AbsoluteBreakMasterV2_CFLAGS = -fobjc-arc -Wall -Wextra -Isrc
AbsoluteBreakMasterV2_FRAMEWORKS = UIKit Foundation CoreGraphics
AbsoluteBreakMasterV2_LIBRARIES = substrate

# Ép ldid sử dụng entitlements cao cấp và cấp quyền đặc biệt khi ký
AbsoluteBreakMasterV2_CODESIGN_FLAGS = -Sg -M AbsoluteBreakV2.entitlements

include $(THEOS_MAKE_PATH)/tool.mk

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app
	cp $(THEOS_OBJ_DIR)/AbsoluteBreakMasterV2 $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app/AbsoluteBreakMasterV2
	if [ -f layout/Applications/AbsoluteBreakMasterV2.app/Info.plist ]; then \
		cp layout/Applications/AbsoluteBreakMasterV2.app/Info.plist $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app/Info.plist; \
	fi
