#ifndef THEME_H
#define THEME_H

#import <UIKit/UIKit.h>

inline UIColor *get_matrix_background(void) {
    return [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:1.0];
}

inline UIColor *get_matrix_green(void) {
    return [UIColor colorWithRed:0.0 green:1.0 blue:0.35 alpha:1.0];
}

inline UIFont *get_matrix_font(void) {
    return [UIFont fontWithName:@"Courier-Bold" size:11];
}

#endif
