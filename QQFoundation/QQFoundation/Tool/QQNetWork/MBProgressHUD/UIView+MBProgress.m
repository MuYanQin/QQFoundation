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
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.delegate = self;
        hud.removeFromSuperViewOnHide = NO;
        [self setHud:hud];//保证只有一个HUD
    }
    return hud;
}
#pragma 显示
/**提示信息*/
- (void)Message:(NSString *)message{
    [self Message:message HiddenAfterDelay:DELAYTIME];
}

/**提示信息，N秒后关闭*/
- (void)Message:(NSString *)message HiddenAfterDelay:(NSTimeInterval)delay{
    [self Message:message YOffset:0.0 HiddenAfterDelay:delay];
}

/**自定义提示框位置，只显示文字*/
- (void)Message:(NSString *)message YOffset:(float)yoffset HiddenAfterDelay:(NSTimeInterval)delay{
    MBProgressHUD *ProgressHUD  = self.hud;
    ProgressHUD.offset = CGPointMake(0, yoffset);// HUD相对于父视图中心点的y轴偏移量
    ProgressHUD.mode = MBProgressHUDModeText;
    ProgressHUD.label.text = message;
    ProgressHUD.margin = 10;
    [ProgressHUD showAnimated:YES];
//    ProgressHUD 
    [ProgressHUD hideAnimated:YES afterDelay:delay];
    
}

/**展示Loading标示*/
- (void)LoadingWith:(NSString *)message{
    MBProgressHUD * ProgressHUD = self.hud;
    ProgressHUD.offset = CGPointMake(0, 0);
    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
    ProgressHUD.label.text = message;
    ProgressHUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    ProgressHUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    ProgressHUD.minSize = CGSizeMake(100, 100);
    [ProgressHUD showAnimated:YES];
}


- (void)Loading{
//    [self touchesEnded:nil withEvent:nil];
    MBProgressHUD * ProgressHUD = self.hud;
    //    hud_0314.contentColor 里面内容的颜色
    ProgressHUD.mode = MBProgressHUDModeIndeterminate;
    ProgressHUD.bezelView.layer.cornerRadius= 4;
    ProgressHUD.bezelView.layer.masksToBounds = YES;
    ProgressHUD.alpha = 0.9;
    ProgressHUD.label.text = @"";
    ProgressHUD.margin = 10;// HUD各元素与HUD边缘的间距
    ProgressHUD.minSize = CGSizeMake(HUDWIDTH, HUDWIDTH);

    //    hud_0314.bezelView.color = [UIColor colorWithHexString:@"e8e8e8"];// 背景框的颜色
    // 需要注意的是如果设置了这个属性，则opacity属性会失效，即不会有半透明效果
    [ProgressHUD showAnimated:YES];
}


/**隐藏*/
- (void)HiddenAfterDelay:(NSTimeInterval)delay{
    [self.hud hideAnimated:YES afterDelay:delay];
}

/**隐藏*/
- (void)Hidden{
    [self.hud hideAnimated:YES];
}


/*是否Loading中*/
- (BOOL)IsLoading{
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
