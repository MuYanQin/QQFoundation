//
//  MCPopViewController.m
//  QQFoundation
//
//  Created by leaduadmin on 2019/4/25.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import "MCPopViewController.h"
#import "UIView+MCPopView.h"
@interface MCPopViewController ()
@property (nonatomic , strong) UIView  *popView;
@end

@implementation MCPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"视图弹出";
    [self nav_RightItemWithStr:@"保存" Selector:nil];
    self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.popView.backgroundColor = [UIColor purpleColor];
    
    
    QQButton *centerBtn = [QQButton buttonWithType:(UIButtonTypeCustom)];
    centerBtn.Qfont(14).QtextClolor(getColorWithHex(@"666666")).Qtarget(self, @selector(clickEvent:)).QInfo(@(0))
    .Qframe(CGRectMake(100, 100, 70, 30)).Qtext(@"中部显示");
    [self.view addSubview:centerBtn];
    
    QQButton *bottomBtn = [QQButton buttonWithType:(UIButtonTypeCustom)];
    bottomBtn.Qfont(14).QtextClolor(getColorWithHex(@"666666")).Qtarget(self, @selector(clickEvent:)).QInfo(@(1))
    .Qframe(CGRectMake(100, 150, 70, 30)).Qtext(@"底部显示");
    [self.view addSubview:bottomBtn];
    
    QQButton *lfetBtn = [QQButton buttonWithType:(UIButtonTypeCustom)];
    lfetBtn.Qfont(14).QtextClolor(getColorWithHex(@"666666")).Qtarget(self, @selector(clickEvent:)).QInfo(@(2))
    .Qframe(CGRectMake(100, 200, 70, 30)).Qtext(@"左部显示");
    [self.view addSubview:lfetBtn];
}

- (void)clickEvent:(QQButton *)btn
{
    if ([btn.info integerValue] ==0) {
        [self.popView showType:(viewShowTypeSlideInFromBottom) dissType:(viewDissTypeSlideOutFromBottom) positionType:(viewPositionTypeCenter) dismissOnBackgroundTouch:YES];
    }else if ([btn.info integerValue] ==1) {
        [self.popView showType:(viewShowTypeSlideInFromBottom) dissType:(viewDissTypeSlideOutFromBottom) positionType:(viewPositionTypeBottom) dismissOnBackgroundTouch:YES];
    }else{
        [self.popView showType:(viewShowTypeSlideInFromLeft) dissType:(viewDissTypeSlideOutFromLeft) positionType:(viewPositionTypeLeft) dismissOnBackgroundTouch:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
