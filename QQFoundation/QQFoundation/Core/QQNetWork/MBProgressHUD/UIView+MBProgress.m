//
//  UIView+MBProgress.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/21.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "UIView+MBProgress.h"
#import <objc/runtime.h>
static char HUDKEY_BE;
static NSInteger const DELAYTIME = 2.0;
static NSInteger const HUDWIDTH = 80;

@implementation UIView (MBProgress)
#pragma 信息提示 Setter Getter
@dynamic hud;
-(void)setHud:(MBProgressHUD *)newValue{
    objc_setAssociatedObject(self, &HUDKEY_BE, newValue, OBJC_ASSOCIATION_RETAIN);
}
-(MBProgressHUD *)hud{
    MBProgressHUD * hud =  objc_getAssociatedObject(self, &HUDKEY_BE);
    if(hud == nil){
        //[UIApplication sharedApplication].delegate.window 会一直保持在最上层。  但是loading的时候不能点击nav的按钮
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.delegate = self;
        hud.removeFromSuperViewOnHide = NO;
        [self setHud:hud];//保证只有一个HUD
    }
    return hud;
}
#pragma 显示
/**提示信息*/
- (void)message:(NSString *)message{
    [self message:message HiddenAfterDelay:DELAYTIME];
}

/**提示信息，N秒后关闭*/
- (void)message:(NSString *)message HiddenAfterDelay:(NSTimeInterval)delay{
    [self message:message YOffset:0.0 HiddenAfterDelay:delay];
}

/**自定义提示框位置，只显示文字*/
- (void)message:(NSString *)message YOffset:(float)yoffset HiddenAfterDelay:(NSTimeInterval)delay{
    MBProgressHUD *ProgressHUD =  [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    ProgressHUD.removeFromSuperViewOnHide = YES;
    ProgressHUD.backgroundView.hidden = YES;
    ProgressHUD.offset = CGPointMake(0, yoffset);// HUD相对于父视图中心点的y轴偏移量
    ProgressHUD.mode = MBProgressHUDModeText;
    ProgressHUD.detailsLabel.text = message;
    ProgressHUD.detailsLabel.textColor = [UIColor whiteColor];
    ProgressHUD.detailsLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    ProgressHUD.minSize = CGSizeMake(0, 0);
    ProgressHUD.margin = 5;
    [ProgressHUD showAnimated:YES];
    ProgressHUD.bezelView.color = [UIColor blackColor];// 背景框的颜色
    [ProgressHUD hideAnimated:YES afterDelay:delay];
}

/**展示Loading标示*/
- (void)loadingWith:(NSString *)message{
    MBProgressHUD * ProgressHUD = self.hud;
    [self bringSubviewToFront:self.hud];
    ProgressHUD.offset = CGPointMake(0, 0);
    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
    ProgressHUD.detailsLabel.text = message;
    ProgressHUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    ProgressHUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    ProgressHUD.minSize = CGSizeMake(HUDWIDTH, HUDWIDTH);
    [ProgressHUD showAnimated:YES];
}


- (void)loading{
    MBProgressHUD * ProgressHUD = self.hud;
    [self bringSubviewToFront:self.hud];
    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
    ProgressHUD.bezelView.layer.cornerRadius= 4;
    ProgressHUD.bezelView.layer.masksToBounds = YES;
    ProgressHUD.detailsLabel.text = @"";
    ProgressHUD.margin = 10;// HUD各元素与HUD边缘的间距
    ProgressHUD.minSize = CGSizeMake(HUDWIDTH, HUDWIDTH);
    ProgressHUD.contentColor = [UIColor whiteColor];
    ProgressHUD.bezelView.color = [UIColor blackColor];// 背景框的颜色
    [ProgressHUD showAnimated:YES];
}


/**隐藏*/
- (void)hiddenAfterDelay:(NSTimeInterval)delay{
    [self.hud hideAnimated:YES afterDelay:delay];
}

/**隐藏*/
- (void)hiddenHUD{
    [self.hud hideAnimated:YES];
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

- (void)hudWasHidden:(MBProgressHUD *)hud
{

}
@end
