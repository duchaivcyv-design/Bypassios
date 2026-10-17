TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = AbsoluteBreakMasterV2

AbsoluteBreakMasterV2_FILES = src/main.mm src/hook_core.mm
AbsoluteBreakMasterV2_CFLAGS = -fobjc-arc -Wall -Wextra -Isrc
AbsoluteBreakMasterV2_FRAMEWORKS = UIKit Foundation CoreGraphics
AbsoluteBreakMasterV2_LIBRARIES = substrate
AbsoluteBreakMasterV2_CODESIGN_FLAGS = -S$(PWD)/AbsoluteBreakMasterV2.entitlements

include $(THEOS_MAKE_PATH)/application.mk

# Chỉ định rõ ràng nếu layout có Info.plist thì nhét vào, không cần copy thủ công tệp nhị phân vì application.mk đã tự lo
after-stage::
	if [ -f layout/Applications/AbsoluteBreakMasterV2.app/Info.plist ]; then \
		cp layout/Applications/AbsoluteBreakMasterV2.app/Info.plist $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app/Info.plist; \
	fi
