//
//  MCDetectionView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/3.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCDetectionView.h"
#import "UIView+QQFrame.h"
#import "QQDevice.h"
@implementation MCDetectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initDetectionView];
        self.backgroundColor = [UIColor purpleColor];
        self.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)setDomains:(NSArray *)Domains
{
    _Domains = Domains;
}
- (void)tap
{
    if (self.Domains.count == 0) {
        NSLog(@"******无可选的域名！******");
        return;
    }
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"\n更改服务 URL" message:[NSString stringWithFormat:@"当前地址为\n%@",QQBaseUrl] preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmA = [UIAlertAction actionWithTitle:_Domains[0] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults]setObject:_Domains[0] forKey:urlKey];
        exit(0);
    }];
    UIAlertAction *confirmB = [UIAlertAction actionWithTitle:_Domains[1] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setObject:_Domains[1] forKey:urlKey];
            exit(0);
    }];
    UIAlertAction *confirmC = [UIAlertAction actionWithTitle:_Domains[2] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setObject:_Domains[2] forKey:urlKey];
            exit(0);
    }];
    [alertCtrl addAction:cancelA];
    [alertCtrl addAction:confirmA];
    [alertCtrl addAction:confirmB];
    [alertCtrl addAction:confirmC];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertCtrl animated:YES completion:nil];
}
- (void)initDetectionView
{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    title.textColor = [UIColor whiteColor];
    [self addSubview:title];
    
    NSString *version = [QQDevice APPVersion];
    NSString *build = [QQDevice APPBuild];
    NSString *titletext = [NSString stringWithFormat:@"V%@ B%@",version,build];
    title.text = titletext;

}

@end
