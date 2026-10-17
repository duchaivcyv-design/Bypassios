TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TOOL_NAME = AbsoluteBreakMasterV2

AbsoluteBreakMasterV2_FILES = src/main.mm src/hook_core.mm src/kernel_breakthrough.c
AbsoluteBreakMasterV2_CFLAGS = -fobjc-arc -Wall -Wextra -Isrc
AbsoluteBreakMasterV2_FRAMEWORKS = UIKit Foundation CoreGraphics
AbsoluteBreakMasterV2_LIBRARIES = substrate
AbsoluteBreakMasterV2_CODESIGN_FLAGS = -SAbsoluteBreakV2.entitlements

include $(THEOS_MAKE_PATH)/tool.mk

after-stage::
	# Tạo sẵn toàn bộ cây thư mục đích trong staging dir
	mkdir -p $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app
	
	# Kiểm tra xem layout có sẵn hay không, nếu có thì copy thẳng tay, không thì tự tạo
	if [ -d "layout/Applications/AbsoluteBreakMasterV2.app" ]; then \
		cp -r layout/Applications/AbsoluteBreakMasterV2.app/* $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app/; \
	fi
	
	# Copy tệp binary thực thi chính vào app bundle
	cp $(THEOS_OBJ_DIR)/AbsoluteBreakMasterV2 $(THEOS_STAGING_DIR)/Applications/AbsoluteBreakMasterV2.app/AbsoluteBreakMasterV2
