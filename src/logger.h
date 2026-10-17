#ifndef LOGGER_H
#define LOGGER_H
#import <Foundation/Foundation.h>
inline void log_system_message(NSString *message) {
    if (message != nil) {
        NSLog(@"[ABSOLUTE_V2_LOG] %@", message);
    }
}
#endif
