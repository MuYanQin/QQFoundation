//
//  QQButton.m
//  QQButtonManer
//
//  Created by 秦慕乔 on 16/3/13.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import "QQButton.h"
#import "UIView+QQFrame.h"
/**
 *  定义宏：按钮中文本和图片的间隔
 */
#define button_Padding 7

//    获得按钮的大小
#define button_btnWidth self.bounds.size.width
#define button_btnHeight self.bounds.size.height
//    获得按钮中UILabel文本的大小
#define button_labelWidth self.titleLabel.bounds.size.width
#define button_labelHeight self.titleLabel.bounds.size.height
//    获得按钮中image图标的大小
#define button_imageWidth self.imageView.bounds.size.width
#define button_imageHeight self.imageView.bounds.size.height

@interface QQButton ()
@property (nonatomic,copy) myButtonBlock tempBlock;
@property (nonatomic,copy) RegisterBlock RegisterBlock;

@end

@implementation QQButton
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title ClickBlock:(myButtonBlock)Click
{

    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = Click;
    return button;
}
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image ClickBlock:(myButtonBlock)Click
{
    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    button.tempBlock = Click;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:button action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image TextAlignment:(ButtonTextAlignment)TextAlignment ClickBlock:(myButtonBlock)Click
{
    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.TextAlignment = TextAlignment;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.adjustsImageWhenHighlighted = NO;
    button.tempBlock = Click;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:button action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 *  注册用button
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame color:(UIColor *)color ClickBlock:(RegisterBlock)Click
{
    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button addTarget:button action:@selector(RegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    button.RegisterBlock = Click;
    return button;
}
- (void)RegisterClick:(QQButton *)button
{
    _RegisterBlock(button);
    __block NSInteger timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
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

- (void)setTextAlignment:(ButtonTextAlignment)TextAlignment
{
    _TextAlignment = TextAlignment;
    [self setNeedsLayout];//主动让系统去调用layoutsubviews
}
- (void)setImageRect:(CGRect)imageRect
{
    _imageRect = imageRect;
}
/**
 *  布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    switch (_TextAlignment) {
        case ButtonTextAlignmentRight:
        {
            [self alignmentRight];
            break;
        }
        case ButtonTextAlignmentLeft:
        {
            [self alignmentLeft];
            break;
        }
        case ButtonTextAlignmentTop:
        {
            [self alignmentTop];
            break;
        }
        case ButtonTextAlignmentBottom:
        {
            [self alignmentBottom];
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
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageWith = button_btnWidth/3;
    CGFloat imageHeight = button_btnHeight/3;
    CGFloat imageX = (button_btnWidth - (frame.size.width + imageWith + 5))/2;
    CGFloat imageY = (button_btnHeight - imageHeight)/2;
    self.imageView.frame = CGRectMake(imageX, imageY, imageWith, imageHeight);
    self.titleLabel.frame = CGRectMake(imageX + imageWith + 5, (button_btnHeight - imageHeight)/2, frame.size.width, imageHeight);
    
}

#pragma mark - 文字在左
- (void)alignmentLeft{
    
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageWith = button_btnWidth/3;
    CGFloat imageHeight = button_btnHeight/3;
    CGFloat imageX = (button_btnWidth - (frame.size.width + imageWith + 5))/2;
    CGFloat imageY = (button_btnHeight - imageHeight)/2;
    self.titleLabel.frame = CGRectMake(imageX, (button_btnHeight - imageHeight)/2, frame.size.width, imageHeight);

    self.imageView.frame = CGRectMake(imageX + frame.size.width + 5, imageY, imageWith, imageHeight);
    NSLog(@"dianji");
}
#pragma mark - 文本在上(居中)
- (void)alignmentTop{
    
    // 计算文本的的宽度
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGFloat imageWith = button_btnWidth/3;
    CGFloat imageHeight = button_btnHeight/3;    
    self.titleLabel.frame = CGRectMake(0, imageHeight/3, button_btnWidth, button_btnHeight/3);
    CGFloat imageX = (button_btnWidth - imageWith) * 0.5;
    self.imageView.frame = CGRectMake(imageX, imageHeight/3 + button_btnHeight/3, imageWith, imageHeight);
    
}
#pragma mark - 文本在下(居中)
- (void)alignmentBottom{

    // 计算文本的的宽度
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGFloat imageWith = button_btnWidth/3;
    CGFloat imageHeight = button_btnHeight/3;
    CGFloat imageX = (button_btnWidth - imageWith) * 0.5;
    
    self.imageView.frame = CGRectMake(imageX, imageHeight/3 , imageWith, imageHeight);
    self.titleLabel.frame = CGRectMake(0, imageHeight*2/3 + imageHeight , button_btnWidth, button_btnHeight/3);

}
- (void)ButtonClick:(QQButton *)button
{
    if (_tempBlock) {
        _tempBlock(button);
    }
}
@end

