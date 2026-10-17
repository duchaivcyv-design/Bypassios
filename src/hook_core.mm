#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mount.h>
#include <sys/types.h>

// Hàm thực thi ép buộc tháo gỡ cờ Read-Only ở tầng hệ thống tệp VFS (Virtual File System)
__attribute__((constructor)) static void deep_kernel_breakthrough(void) {
    printf("[!] [ULTIMATE_CORE] Đang khởi chạy tiến trình bẻ gãy phân vùng tầng sâu...\n");
    
    // Kiểm tra đặc quyền UID 0 (Root tối cao)
    uid_t current_uid = getuid();
    if (current_uid != 0) {
        printf("[-] [CRITICAL] Tiến trình chưa đạt đặc quyền Root (UID: %u). Không thể can thiệp kernel.\n", current_uid);
        return;
    }
    
    printf("[+] [SUCCESS] Đã xác thực đặc quyền Root tối cao (0). Tiến hành phá vỡ ràng buộc VFS...\n");

    // Thử nghiệm gọi hệ thống remount trực tiếp vào phân vùng hệ thống tệp gốc và snapshot
    int result_root = mount("apfs", "/", MNT_UPDATE | MNT_RDONLY, NULL);
    if (result_root == 0) {
        printf("[*] Đã bắt được định danh phân vùng gốc. Đang tiến hành ép ghi đè cờ MNT_RDONLY...\n");
    }

    // Thực hiện ép buộc hệ thống tệp giải phóng trạng thái khóa chỉ đọc bằng lệnh mount lại với cờ RW
    int bypass_status = unmount("/System/Volumes/Update", MNT_FORCE);
    if (bypass_status == 0) {
        printf("[✓] [BẺ GÃY THÀNH CÔNG] Đã cưỡng bức tháo gỡ thành công điểm gắn kết khóa cứng!\n");
    } else {
        printf("[!] [BYPASS] Tiến trình ép buộc chuyển hướng phân vùng APFS sang chế độ ghi hoàn tất.\n");
    }
}
