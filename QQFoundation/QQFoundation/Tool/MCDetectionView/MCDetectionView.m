//
//  MCDetectionView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/3.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCDetectionView.h"
#import "YYFPSLabel.h"
#import "UIView+QQFrame.h"
#import "QQDevice.h"
@implementation MCDetectionView
{
    CGPoint _touchPoint;
    NSArray *_URLArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initDetectionView];
        self.backgroundColor = [UIColor purpleColor];
        self.alpha = 0.7;
        self.layer.cornerRadius = 4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.numberOfTapsRequired = 2;
        if (ServerType ==1) {
            [self addGestureRecognizer:tap];
            _URLArray = @[QQBaseUrl,@"http://192.168.1.136:9021/api/appuser",@"http://www.baidu.com"];
        }
    }
    return self;
}
- (void)tap
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"\n更改服务器 URL" message:[NSString stringWithFormat:@"当前地址为\n%@",QQBaseUrl] preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmA = [UIAlertAction actionWithTitle:_URLArray[0] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults]setObject:_URLArray[0] forKey:@"URL"];
        exit(0);
    }];
    UIAlertAction *confirmB = [UIAlertAction actionWithTitle:_URLArray[1] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setObject:_URLArray[1] forKey:@"URL"];
            exit(0);
    }];
    UIAlertAction *confirmC = [UIAlertAction actionWithTitle:_URLArray[2] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setObject:_URLArray[2] forKey:@"URL"];
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
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - 20)];
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    title.textColor = [UIColor whiteColor];
    [self addSubview:title];
    
    NSString *version = [QQDevice APPVersion];
    NSString *build = [QQDevice APPBuild];
    NSString *titletext = [NSString stringWithFormat:@"V%@ B%@",version,build];
    title.text = titletext;
    YYFPSLabel *ly = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, self.height - 20, self.width, 20)];
    ly.textColor = [UIColor whiteColor];
    [self addSubview:ly];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    //按钮刚按下的时候，获取此时的起始坐标
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取当前移动过程中的按钮坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    //偏移量(当前坐标 - 起始坐标 = 偏移量)
    CGFloat offsetX = currentPosition.x - _touchPoint.x;
    CGFloat offsetY = currentPosition.y - _touchPoint.y;
    
    //移动后的按钮中心坐标
    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
    
    //父试图的宽高
    CGFloat superViewWidth = self.superview.frame.size.width;
    CGFloat superViewHeight = self.superview.frame.size.height;
    CGFloat btnX = self.frame.origin.x;
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    //x轴左右极限坐标
    if (btnX > superViewWidth){
        //按钮右侧越界
        CGFloat centerX = superViewWidth - btnW/2;
        self.center = CGPointMake(centerX, centerY);
    }else if (btnX < 0){
        //按钮左侧越界
        CGFloat centerX = btnW * 0.5;
        self.center = CGPointMake(centerX, centerY);
    }
    
    //默认都是有导航条的，有导航条的，父试图高度就要被导航条占据，固高度不够
    CGFloat defaultNaviHeight = 64;
    CGFloat judgeSuperViewHeight = superViewHeight - defaultNaviHeight;
    
    //y轴上下极限坐标
    if (btnY <= 0){
        //按钮顶部越界
        centerY = btnH * 0.7;
        self.center = CGPointMake(centerX, centerY);
    }
    else if (btnY > judgeSuperViewHeight){
        //按钮底部越界
        CGFloat y = superViewHeight - btnH * 0.5;
        self.center = CGPointMake(btnX, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
    CGFloat btnWidth = self.frame.size.width;
    CGFloat btnHeight = self.frame.size.height;
    CGFloat btnY = self.frame.origin.y;
    
    //自动识别贴边
    if (self.center.x >= self.superview.frame.size.width/2) {
        
        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠右自动吸边
            CGFloat btnX = self.superview.frame.size.width - btnWidth;
            self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠左吸边
            CGFloat btnX = 0;
            self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        }];
    }
}

@end
