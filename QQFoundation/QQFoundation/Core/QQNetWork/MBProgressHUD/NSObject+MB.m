//
//  NSObject+MB.m
//  QQFoundation
//
//  Created by qinmuqiao on 2019/3/21.
//  Copyright © 2019年 Yuan er. All rights reserved.
//

#import "NSObject+MB.h"
#import <objc/runtime.h>
#import "QQAppDefine.h"
#import "UIView+QQFrame.h"
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
        hud = [MBProgressHUD showHUDAddedTo:self.currentShowingVC.view animated:YES];
        hud.delegate = self;
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.color = [UIColor blackColor];// 背景框的颜色
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

    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = message;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];// 背景框的颜色
    hud.contentColor = [UIColor whiteColor];
    //hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
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
    MBProgressHUD * hud =  objc_getAssociatedObject(self, &HUDKEY_BE);
    if (hud) {
        [hud hideAnimated:YES];
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

- (UIViewController *)currentShowingVC {
    //获得当前活动窗口的根视图
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

//注意考虑几种特殊情况：①A present B, B present C，参数vc为A时候的情况
/* 完整的描述请参见文件头部 */
- (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc
{
    //方法1：递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) { //注要优先判断vc是否有弹出其他视图，如有则当前显示的视图肯定是在那上面
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }
    return currentShowingVC;
}

@end
