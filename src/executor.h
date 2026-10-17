#ifndef EXECUTOR_H
#define EXECUTOR_H
#import <Foundation/Foundation.h>
#include <stdio.h>
inline NSString *execute_shell_command_live(NSString *command) {
    if (command == nil || [command length] == 0) {
        return @"[-] Lỗi: Lệnh trống không thể thực thi.";
    }
    NSMutableString *outputResult = [NSMutableString string];
    FILE *pipe = popen([command UTF8String], "r");
    if (!pipe) {
        return @"[-] Lỗi nghiêm trọng: Không thể mở luồng tiến trình popen.";
    }
    char buffer[128];
    while (fgets(buffer, sizeof(buffer), pipe) != NULL) {
        NSString *line = [NSString stringWithUTF8String:buffer];
        if (line != nil) {
            [outputResult appendString:line];
        }
    }
    int exitCode = pclose(pipe);
    [outputResult appendFormat:@"\n[✓] Tiến trình kết thúc với mã trạng thái: %d\n", exitCode];
    return outputResult;
}
#endif
