//
//  UIViewController+QQPrintDealloc.m
//  QQUIKit
//
//  Created by tlt on 17/3/21.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "UIViewController+QQPrintDealloc.h"
#import "QQTool.h"
@implementation UIViewController (QQPrintDealloc)
+ (void)load
{
    QQ_methodSwizzle([self class], NSSelectorFromString(@"dealloc"), @selector(QQ_dealloc));
}
- (void)QQ_dealloc
{
    NSLog(@"dealloc-> %@",[self class]);
}
@end
