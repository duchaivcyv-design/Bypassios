TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = AbsoluteBreakMasterV2

AbsoluteBreakMasterV2_FILES = src/main.mm src/hook_core.mm
AbsoluteBreakMasterV2_CFLAGS = -fobjc-arc -Wall -Wextra -Isrc
AbsoluteBreakMasterV2_FRAMEWORKS = UIKit Foundation CoreGraphics
AbsoluteBreakMasterV2_LIBRARIES = substrate
AbsoluteBreakMasterV2_CODESIGN_FLAGS = -SAbsoluteBreakV2.entitlements

include $(THEOS_MAKE_PATH)/application.mk

# Ép buộc giai đoạn dựng hình gom đúng chuẩn Info.plist vào chung thư mục .app với tệp nhị phân
after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app
	if [ -f layout/Applications/AbsoluteBreakMasterV2.app/Info.plist ]; then \
		cp layout/Applications/AbsoluteBreakMasterV2.app/Info.plist $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app/Info.plist; \
	fi
