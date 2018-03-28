//
//  UINavigation+SXFixSpace.m
//  UINavigation-SXFixSpace
//
//  Created by charles on 2017/9/8.
//  Copyright © 2017年 None. All rights reserved.
//

#import "UINavigation+SXFixSpace.h"
#import "QQTool.h"
#import <UIKit/UIKit.h>
#import <Availability.h>

#define deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation UINavigationBar (SXFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QQ_methodSwizzle(self, @selector(layoutSubviews), @selector(sx_layoutSubviews));
    });
}

-(void)sx_layoutSubviews{
    [self sx_layoutSubviews];
    
    if (deviceVersion >= 11) {//需要调节
        self.layoutMargins = UIEdgeInsetsZero;
        CGFloat space = sx_defaultFixSpace;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, space);//可修正iOS11之后的偏移
                break;
            }
        }
    }
}

@end

@implementation UINavigationItem (SXFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QQ_methodSwizzle(self, @selector(setLeftBarButtonItem:), @selector(sx_setLeftBarButtonItem:));
        QQ_methodSwizzle(self, @selector(setLeftBarButtonItems:), @selector(sx_setLeftBarButtonItems:));

    });
    
}

-(void)sx_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if (deviceVersion >= 11) {
        [self sx_setLeftBarButtonItem:leftBarButtonItem];
    } else {
        if (leftBarButtonItem) {//存在按钮且需要调节
            [self setLeftBarButtonItems:@[leftBarButtonItem]];
        } else {//不存在按钮,或者不需要调节
            [self sx_setLeftBarButtonItem:leftBarButtonItem];
        }
    }
}

-(void)sx_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    if (leftBarButtonItems.count) {
        NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:sx_defaultFixSpace-20]];//可修正iOS11之前的偏移
        [items addObjectsFromArray:leftBarButtonItems];
        [self sx_setLeftBarButtonItems:items];
    } else {
        [self sx_setLeftBarButtonItems:leftBarButtonItems];
    }
}

-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
