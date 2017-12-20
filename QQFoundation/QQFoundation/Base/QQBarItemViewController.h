//
//  QQBarItemViewController.h
//  QQFoundation
//
//  Created by Maybe on 2017/12/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface QQBarItemViewController : UIViewController

/**
 *  添加nav上右按钮，图片
 */
- (void)nav_RightItemWithImg:(NSString *)imgName Selector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串
 */
- (void)nav_RightItemWithStr:(NSString *)str Selector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串, 字体颜色
 */
- (void)nav_RightItemWithStr:(NSString *)str TintColor:(UIColor *)tintColor Selector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串, 字体颜色, 字体大小
 */
-(void)nav_RightItemWithStr:(NSString *)str TintColor:(UIColor *)tintColor FontSize:(CGFloat)size Selector:(SEL)sel;

/**
 *  添加nav上左按钮，字符串
 */
- (void)nav_LeftItemWithStr:(NSString *)str Selector:(SEL)sel;

@end
