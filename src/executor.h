#ifndef EXECUTOR_H
#define EXECUTOR_H

#import <Foundation/Foundation.h>
#include <stdio.h>

inline NSString *execute_command_absolute(NSString *command) {
    if (command == nil || [command length] == 0) {
        return @"[-] Lỗi: Chuỗi lệnh trống.";
    }

    NSMutableString *output = [NSMutableString string];
    FILE *pipe = popen([command UTF8String], "r");
    if (!pipe) {
        return @"[-] Lỗi nghiêm trọng: Không thể khởi tạo luồng popen.";
    }

    char buffer[256];
    while (fgets(buffer, sizeof(buffer), pipe) != NULL) {
        NSString *line = [NSString stringWithUTF8String:buffer];
        if (line != nil) {
            [output appendString:line];
        }
    }

    int status = pclose(pipe);
    [output appendFormat:@"\n[✓] Trạng thái thoát tiến trình: %d\n", status];
    return output;
}

#endif
