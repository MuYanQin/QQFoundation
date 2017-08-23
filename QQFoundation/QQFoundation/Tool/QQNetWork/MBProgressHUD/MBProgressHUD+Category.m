//
//  MBProgressHUD+Category.m
//  wanlb
//
//  Created by 刘永峰 on 16/3/15.
//  Copyright © 2016年 Witgo. All rights reserved.
//

#import "MBProgressHUD+Category.h"
//#import "UIImage+EMGIF.h"
//#import "UIColor+YFCategory.h"
#import "UIColor+Hexadecimal.h"
static MBProgressHUD *load_hud = nil;

@implementation MBProgressHUD (Category)

/**
 *
 *  @brief 显示加载提示
 *
 *  @param title     文本
 *  @param superView 父视图
 *
 *  @return hud
 */
+ (MBProgressHUD *)showHUD:(NSString *)title toView:(UIView *)superView
{
    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    if (load_hud) {
        [self hideHUD];
    }
    load_hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    load_hud.mode = MBProgressHUDModeCustomView;
    UIImageView *customView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    customView.image = [UIImage sd_animatedGIFNamed:@"loading"];
    load_hud.customView = customView;
    load_hud.cornerRadius = 4;
    load_hud.alpha = 0.9;
    load_hud.margin = 15;
    load_hud.minSize = CGSizeMake(80, 80);
    load_hud.labelColor = [UIColor darkGrayColor];
    load_hud.labelFont = [UIFont systemFontOfSize:12];
    load_hud.color = [UIColor colorWithHexString:@"e8e8e8"];
    //有无灰色的遮罩视图
    load_hud.dimBackground = NO;

    load_hud.labelText = title;
    return load_hud;
}

/**
 *  @brief  隐藏加载提示
 */
+ (void)hideHUD
{
    if (load_hud) {
        [load_hud hide:YES];
        load_hud = nil;
    }
}

/**
 *  @brief 显示提示文本框
 *
 *  @param text      提示文本
 *  @param superView 父视图
 */
+ (void)showTotast:(NSString *)text toView:(UIView *)superView
{
    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *text_hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    text_hud.mode = MBProgressHUDModeText;
    text_hud.color = [UIColor colorWithHexString:@"e8e8e8"];
    text_hud.cornerRadius = 4;
    text_hud.alpha = 0.9;
    text_hud.margin = 15;
    text_hud.minSize = CGSizeMake(80, 0);
    text_hud.detailsLabelColor = [UIColor darkGrayColor];
    text_hud.detailsLabelText = text?text:@"失败";
    text_hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    text_hud.removeFromSuperViewOnHide = YES;
    [text_hud hide:YES afterDelay:1];
}

@end
