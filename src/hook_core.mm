#import <Foundation/Foundation.h>
#include <substrate.h>

// Hàm nguyên thủy của hệ thống hoặc ứng dụng kiểm tra trạng thái khóa
static bool (*original_isLocked)(id self, SEL _cmd);

// Hàm thay thế (Hook function) luôn trả về NO (đã mở khóa / bẻ gãy hoàn toàn trạng thái khóa)
static bool replaced_isLocked(id self, SEL _cmd) {
    NSLog(@"[+] [ABSOLUTE_HOOK] Đã chặn và vô hiệu hóa hàm kiểm tra khóa thành công!");
    return false; // Ép buộc trạng thái luôn là KHÔNG KHÓA (Unlocked)
}

__attribute__((constructor)) static void init_absolute_hook(void) {
    NSLog(@"[+] [ABSOLUTE_CORE] Khởi động module tiêm mã bẻ gãy khóa trực tiếp...");
    
    // Tìm và móc nối tới phương thức kiểm tra khóa mục tiêu trong runtime
    Class targetClass = objc_getClass("SecurityManager"); // Hoặc lớp quản lý khóa của ứng dụng mục tiêu
    if (targetClass) {
        Method targetMethod = class_getInstanceMethod(targetClass, @selector(isLocked));
        if (targetMethod) {
            method_setImplementation(targetMethod, (IMP)replaced_isLocked);
            NSLog(@"[+] [ABSOLUTE_CORE] Móc nối thành công vào phương thức isLocked!");
        }
    }
}
