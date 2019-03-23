//
//  NSObject+MB.m
//  QQFoundation
//
//  Created by qinmuqiao on 2019/3/21.
//  Copyright © 2019年 慕纯. All rights reserved.
//

#import "NSObject+MB.h"
#import <objc/runtime.h>

static char HUDKEY_BE;
static NSInteger const DELAYTIME = 2.0;
static NSInteger const HUDWIDTH = 80;

@implementation NSObject (MB)
- (void)setHud:(MBProgressHUD *)hud
{
    objc_setAssociatedObject(self, &HUDKEY_BE, hud, OBJC_ASSOCIATION_RETAIN);
}
- (MBProgressHUD *)hud
{
    MBProgressHUD * hud =  objc_getAssociatedObject(self, &HUDKEY_BE);
    if(hud == nil){
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.delegate = self;
        hud.top = MCNavHeight;//记载loading回偏移
        hud.offset = CGPointMake(0, -MCNavHeight);
        hud.removeFromSuperViewOnHide = YES;
        [self setHud:hud];//保证只有一个HUD
    }
    return hud;
}
#pragma 显示
/**提示信息*/
- (void)message:(NSString *)message{
    [self message:message after:DELAYTIME];
}

/**提示信息，N秒后关闭*/
- (void)message:(NSString *)message after:(NSTimeInterval)delay{
    [self message:message yOffset:0.0 after:delay];
}

/**自定义提示框位置，只显示文字*/
- (void)message:(NSString *)message yOffset:(float)yoffset after:(NSTimeInterval)delay{
    MBProgressHUD *hud = self.hud;
    hud.userInteractionEnabled = NO;
    hud.backgroundView.hidden = YES;
//    hud.offset = CGPointMake(0, yoffset);// HUD相对于父视图中心点的y轴偏移量
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    hud.minSize = CGSizeMake(0, 0);
    hud.margin = 5;
    hud.bezelView.color = [UIColor blackColor];// 背景框的颜色
    [hud hideAnimated:YES afterDelay:delay];
}

/**展示Loading标示*/
- (void)loadingWith:(NSString *)message{
    MBProgressHUD * hud = self.hud;
    hud.userInteractionEnabled = YES;
//    hud.offset = CGPointMake(0, 0);
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = message;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.minSize = CGSizeMake(HUDWIDTH, HUDWIDTH);
    [hud showAnimated:YES];
}


- (void)loading{
    MBProgressHUD * hud = self.hud;
    hud.userInteractionEnabled = YES;
    hud.backgroundView.hidden = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.layer.cornerRadius= 4;
    hud.bezelView.layer.masksToBounds = YES;
    hud.detailsLabel.text = @"";
    hud.margin = 10;// HUD各元素与HUD边缘的间距
    hud.minSize = CGSizeMake(HUDWIDTH, HUDWIDTH);
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];// 背景框的颜色
    [hud showAnimated:YES];
}

/**隐藏*/
- (void)hiddenHUD{
    if (self.hud) {
        [self.hud hideAnimated:YES];
    }
}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    objc_setAssociatedObject(self, &HUDKEY_BE, nil, OBJC_ASSOCIATION_RETAIN);
}
/*是否Loading中*/
- (BOOL)isLoading{
    MBProgressHUD * ProgressHUD = self.hud;
    
    if((ProgressHUD.mode == MBProgressHUDModeIndeterminate || ProgressHUD.mode == MBProgressHUDModeIndeterminate) &&
       !ProgressHUD.isHidden){
        return YES;
    }
    else{
        return NO;
    }
}
@end
