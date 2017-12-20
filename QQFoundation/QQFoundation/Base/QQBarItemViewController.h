//
//  QQBarItemViewController.h
//  QQFoundation
//
//  Created by Maybe on 2017/12/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "BaseViewController.h"

@interface QQBarItemViewController : BaseViewController

/**
 *  添加nav上右按钮，图片
 */
- (void)addRightBtnWithImgName:(NSString *)imgName andSelector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串
 */
- (void)addRightBtnWithStr:(NSString *)str andSelector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串, 字体颜色
 */
- (void)addNaviRightBtnWithStr:(NSString *)str andTintColor:(UIColor *)tintColor andSelector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串, 字体颜色, 字体大小
 */
-(void)addNaviRightBtnWithStr:(NSString *)str andTintColor:(UIColor *)tintColor andFontSize:(CGFloat)size andSelector:(SEL)sel;

/**
 *  添加nav上左按钮，字符串
 */
- (void)addLeftBtnWithStr:(NSString *)str andSelector:(SEL)sel;

@end
