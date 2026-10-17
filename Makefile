TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

# Đổi từ TOOL_NAME sang APPLICATION_NAME để Theos tự động dựng chuẩn cấu trúc .app cho SpringBoard
APPLICATION_NAME = AbsoluteBreakMasterV2

AbsoluteBreakMasterV2_FILES = src/main.mm src/hook_core.mm
AbsoluteBreakMasterV2_CFLAGS = -fobjc-arc -Wall -Wextra -Isrc
AbsoluteBreakMasterV2_FRAMEWORKS = UIKit Foundation CoreGraphics
AbsoluteBreakMasterV2_LIBRARIES = substrate
AbsoluteBreakMasterV2_CODESIGN_FLAGS = -SAbsoluteBreakV2.entitlements

include $(THEOS_MAKE_PATH)/application.mk
