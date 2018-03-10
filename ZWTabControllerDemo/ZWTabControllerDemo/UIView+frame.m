//
//  UIView+frame.m
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

- (void)setWl_x:(CGFloat)wl_x {
    CGRect  frame = self.frame;
    frame.origin.x = wl_x;
    self.frame = frame;
}

- (CGFloat)wl_x {
    return self.frame.origin.x;
}

- (void)setWl_y:(CGFloat)wl_y {
    CGRect frame = self.frame;
    frame.origin.y = wl_y;
    self.frame = frame;
}

- (CGFloat)wl_y {
    return self.frame.origin.y;
}

- (void)setWl_width:(CGFloat)wl_width {
    CGRect frame = self.frame;
    frame.size.width = wl_width;
    self.frame = frame;
}
- (CGFloat)wl_width {
    return self.frame.size.width;
}

- (void)setWl_height:(CGFloat)wl_height {
    CGRect frame = self.frame;
    frame.size.height = wl_height;
    self.frame = frame;
}

- (CGFloat)wl_height {
    return self.frame.size.height;
}

- (void)setWl_centerX:(CGFloat)wl_centerX {
    CGPoint center = self.center;
    center.x = wl_centerX;
    self.center = center;
}

- (CGFloat)wl_centerX {
    return self.center.x;
}

- (void)setWl_centerY:(CGFloat)wl_centerY {
    CGPoint center = self.center;
    center.y = wl_centerY;
    self.center = center;
}

- (CGFloat)wl_centerY {
    return self.center.y;
}

- (void)setWl_size:(CGSize)wl_size {
    CGRect frame = self.frame;
    frame.size = wl_size;
    self.frame = frame;
}

- (CGSize)wl_size {
    return self.frame.size;
}
@end
