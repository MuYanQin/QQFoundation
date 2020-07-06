//
//  QYTabBar.m
//  QQFoundation
//
//  Created by leaduMac on 2020/7/5.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "QYTabBar.h"

@implementation QYTabBar

//重写setsetItems 方法 使tabbar无法写入 自身的item
- (NSArray<UITabBarItem *> *)items {
    return @[];
}
- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated{}
- (void)setItems:(NSArray<UITabBarItem *> *)items{}

@end
