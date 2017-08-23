//
//  uiview+MB.m
//  Teacher
//
//  Created by tlt on 16/8/11.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "uiview+MB.h"
#import <objc/runtime.h>
#import "UIColor+Hexadecimal.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
static char HUDKEY_BE;

@implementation  UIView (uiview_MB)

#pragma 信息提示 Setter Getter
@dynamic hud;
-(void)setHud:(MBProgressHUD *)newValue{
    objc_setAssociatedObject(self.superview, &HUDKEY_BE, newValue, OBJC_ASSOCIATION_RETAIN);
}
-(MBProgressHUD *)hud{
    MBProgressHUD * hud_0314 = [MBProgressHUD HUDForView:self];
    
    if(hud_0314 == nil){
        hud_0314 = [MBProgressHUD showHUDAddedTo:self animated:YES];
        [self addSubview:hud_0314];
    }
    
    return hud_0314;
}
#pragma 显示
/**提示信息*/
- (void)Message:(NSString *)message{
    [self Message:message HiddenAfterDelay:2.0];
}

/**提示信息，N秒后关闭*/
- (void)Message:(NSString *)message HiddenAfterDelay:(NSTimeInterval)delay{
    [self Message:message YOffset:0.0 HiddenAfterDelay:delay];
}

/**自定义提示框位置，只显示文字*/
- (void)Message:(NSString *)message YOffset:(float)yoffset HiddenAfterDelay:(NSTimeInterval)delay{
    
    MBProgressHUD * hud_0314 = self.hud;
    hud_0314.yOffset = yoffset;// HUD相对于父视图中心点的y轴偏移量
//    hud_0314.xOffset //x轴偏移量
    hud_0314.mode = MBProgressHUDModeText;
    hud_0314.labelText = message;
    hud_0314.margin = 10;
    [hud_0314  show:true];
    [hud_0314  hide:true afterDelay:delay];
    
}

/**展示Loading标示*/
- (void)Loading:(NSString *)message{
    MBProgressHUD * hud_0314 = self.hud;
    hud_0314.yOffset = 0.0;
    hud_0314.mode = MBProgressHUDModeIndeterminate;
    hud_0314.labelText = message;
    [hud_0314  show:true];
}

/**隐藏*/
- (void)HiddenAfterDelay:(NSTimeInterval)delay{
    [self.hud  hide:true afterDelay:delay];
}

/**隐藏*/
- (void)Hidden{
    [self.hud hide:YES];
}

- (void)Loading_0314{
    [self touchesEnded:nil withEvent:nil];
    MBProgressHUD * hud_0314 = self.hud;
    
    hud_0314.mode = MBProgressHUDModeCustomView;
    FLAnimatedImageView *customView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    NSData *image = [NSData dataWithContentsOfFile:filePath];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:image];
    customView.animatedImage = animatedImage1;
    hud_0314.customView = customView;
    hud_0314.cornerRadius = 4;
    hud_0314.alpha = 0.9;
    hud_0314.margin = 0;// HUD各元素与HUD边缘的间距
    hud_0314.minSize = CGSizeMake(50, 50);
    hud_0314.labelColor = [UIColor darkGrayColor];// 标题文本的字体及颜色
    hud_0314.labelFont = [UIFont systemFontOfSize:12];
    hud_0314.color = [UIColor colorWithHexString:@"e8e8e8"];// 背景框的颜色
    // 需要注意的是如果设置了这个属性，则opacity属性会失效，即不会有半透明效果
    //有无灰色的遮罩视图
    hud_0314.dimBackground = NO;
    
    [hud_0314  show:true];
    
}

/*是否Loading中*/
- (BOOL)IsLoading{
    MBProgressHUD * hud_0314 = self.hud;
    
    if((hud_0314.mode == MBProgressHUDModeIndeterminate || hud_0314.mode == MBProgressHUDModeIndeterminate) &&
       !hud_0314.isHidden){
        return YES;
    }
    else{
        return NO;
    }
}
@end
