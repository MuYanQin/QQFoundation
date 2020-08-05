//
//  QQButton.m
//  QQButtonManer
//
//  Created by Yuan er on 16/3/13.
//  Copyright © 2016年 Yuan er. All rights reserved.
//

#import "QQButton.h"
#import "UIView+QQFrame.h"


//    获得按钮的大小
#define button_btnWidth              self.bounds.size.width
#define button_btnHeight             self.bounds.size.height

@interface QQButton ()

@property (nonatomic , assign) CGSize  imageSize;
@property (nonatomic , assign) QTextPosition  position;
@end

@implementation QQButton
{
    dispatch_source_t _timer;
}
-(UIButton *(^)(id))QInfo
{
    return ^UIButton *(id info){
        self.info = info;
        return self;
    };
}
- (UIButton *(^)(CGSize))QimageSize
{
    return ^UIButton *(CGSize size){
        self.imageSize = size;
        return self;
    };
}

- (UIButton *(^)(QTextPosition))QtextPosition
{
    return ^UIButton *(QTextPosition position){
        self.position = position;
        return self;
    };
}
- (void)startCountdown
{
    __block NSInteger timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:@"点击重新获取验证码" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeOut % 61;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,@"S"] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
- (void)resetCountdown
{
    dispatch_source_cancel(_timer);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:@"点击重新获取验证码" forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    });
}
/**
 *  布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.position) {
        case Tright:
        {
            [self alignmentRight];
            break;
        }
        case Tleft:
        {
            [self alignmentLeft];
            break;
        }
        case Ttop:
        {
            [self alignmentTop];
            break;
        }
        case Tbottom:
        {
            [self alignmentBottom];
            break;
        }
        case Tnone:
        {
            if (self.imageSize.width <=0) {
                return;
            }
            CGRect rect = self.imageView.frame;
            rect.size = self.imageSize;
            self.imageView.frame = rect;
            break;
        }
        default:
            break;
    }
}
#pragma mark - 文字在右
- (void)alignmentRight{

    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    self.titleLabel.numberOfLines = 0;
    CGFloat width = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil].size.width;
    
    if (width > button_btnWidth - 15 - self.imageSize.width ) {
        width = button_btnWidth - 15 - self.imageSize.width;
    }
    
    CGFloat imageWith = 0;
    CGFloat imageHeight = 0;
    if (self.imageSize.width>0) {
        imageWith = self.imageSize.width;
        imageHeight = self.imageSize.height;
    }else{
        imageWith = 2* button_btnWidth/3;
        imageHeight = 2* button_btnHeight/3;
    }
    CGFloat total  = imageWith + width + 5;
    
    CGFloat imageX = (button_btnWidth - total)/2;
    CGFloat imageY = (button_btnHeight - imageHeight)/2;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageWith, imageHeight);
    self.titleLabel.frame = CGRectMake(imageX + 5 +imageWith , imageY, width, imageHeight);

}

#pragma mark - 文字在左
- (void)alignmentLeft{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    self.titleLabel.numberOfLines = 0;
    CGFloat width = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil].size.width;
    
    if (width > button_btnWidth - 15 - self.imageSize.width ) {
        width = button_btnWidth - 15 - self.imageSize.width;
    }
    CGFloat imageWith = 0;
    CGFloat imageHeight = 0;
    if (self.imageSize.width>0) {
        imageWith = self.imageSize.width;
        imageHeight = self.imageSize.height;
    }else{
        imageWith = 2* button_btnWidth/3;
        imageHeight = 2* button_btnHeight/3;
    }
    CGFloat total  = imageWith + width + 5;
    CGFloat labelX = (button_btnWidth - total)/2;
    CGFloat labelY = (button_btnHeight - imageHeight)/2;
    
    self.titleLabel.frame = CGRectMake(labelX, labelY, width, imageHeight);
    self.imageView.frame = CGRectMake(labelX + width + 5, labelY, imageWith, imageHeight);
}
#pragma mark - 文本在上(居中)
- (void)alignmentTop{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    
    CGFloat height = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil].size.height;
    
    CGFloat imageWith = 0;
    CGFloat imageHeight = 0;
    if (self.imageSize.width>0) {
        imageWith = self.imageSize.width;
        imageHeight = self.imageSize.height;
    }else{
       imageWith = 2* button_btnWidth/3;
       imageHeight = 2* button_btnHeight/3;
    }
    CGFloat total  = imageHeight + height + 5;
    self.titleLabel.frame = CGRectMake(0, (button_btnHeight - total)/2, button_btnWidth, height);
    CGFloat imageX = (button_btnWidth - imageWith) * 0.5;
    self.imageView.frame = CGRectMake(imageX, height + (button_btnHeight - total)/2 + 5, imageWith, imageHeight);
}
#pragma mark - 文本在下(居中)
- (void)alignmentBottom{

    // 计算文本的的宽度
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGFloat height = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil].size.height;
    CGFloat imageWith = 0;
    CGFloat imageHeight = 0;
    if (self.imageSize.width>0) {
        imageWith = self.imageSize.width;
        imageHeight = self.imageSize.height;
    }else{
        imageWith = 2* button_btnWidth/3;
        imageHeight = 2* button_btnHeight/3;
    }
    CGFloat total  = imageHeight + height +5 ;
    CGFloat imageX = (button_btnWidth - imageWith) * 0.5;
    CGFloat imageY = (button_btnHeight - total)/2;
    self.imageView.frame = CGRectMake(imageX, imageY , imageWith, imageHeight);
    self.titleLabel.frame = CGRectMake(0, imageY+ imageHeight +5, button_btnWidth, height);
}
@end

