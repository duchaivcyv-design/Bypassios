#ifndef THEME_H
#define THEME_H
#import <UIKit/UIKit.h>
inline UIColor *get_terminal_background(void) {
    return [UIColor colorWithRed:0.03 green:0.03 blue:0.03 alpha:1.0];
}
inline UIColor *get_terminal_text_color(void) {
    return [UIColor colorWithRed:0.0 green:1.0 blue:0.3 alpha:1.0]; // Xanh lá hacker đặc trưng
}
inline UIFont *get_terminal_font(void) {
    return [UIFont fontWithName:@"Courier" size:12];
}
#endif
