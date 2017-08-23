//
//  QQButton.m
//  QQButtonManer
//
//  Created by 秦慕乔 on 16/3/13.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//

#import "QQButton.h"
#import "UIView+QQFrame.h"
#import <objc/runtime.h>

/**
 *  图标在上，文本在下按钮的图文间隔比例（0-1），默认0.8
 */
#define fl_buttonTopRadio 0.7
/**
 *  图标在下，文本在上按钮的图文间隔比例（0-1），默认0.5
 */
#define fl_buttonBottomRadio 0.5
/**
 *  定义宏：按钮中文本和图片的间隔
 */
#define fl_padding 7
//#define fl_btnRadio 0.6
//    获得按钮的大小
#define fl_btnWidth self.bounds.size.width
#define fl_btnHeight self.bounds.size.height
//    获得按钮中UILabel文本的大小
#define fl_labelWidth self.titleLabel.bounds.size.width
#define fl_labelHeight self.titleLabel.bounds.size.height
//    获得按钮中image图标的大小
#define fl_imageWidth self.imageView.bounds.size.width
#define fl_imageHeight self.imageView.bounds.size.height

@interface QQButton ()
@property (nonatomic,copy) myButtonBlock tempBlock;
@property (nonatomic,copy) RegisterBlock RegisterBlock;

@end

@implementation QQButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        _buttonTopRadio = 0.9;

    }
    return self;
}
+ (instancetype)fl_shareButton{
    return [[self alloc] init];
}

+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title andBlock:(myButtonBlock)block
{

    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tempBlock = block;
    return button;
}
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image andBlock:(myButtonBlock)block
{
    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    button.tempBlock = block;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:button action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (QQButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image status:(FLAlignmentStatus)status andBlock:(myButtonBlock)block
{
    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.status = status;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.adjustsImageWhenHighlighted = NO;
    button.tempBlock = block;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:button action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 *  注册用button
 *
 *  @param frame <#frame description#>
 *  @param color <#color description#>
 *  @param block <#block description#>
 *
 *  @return <#return value description#>
 */
+ (QQButton *)buttonWithFrame:(CGRect)frame color:(UIColor *)color andBlock:(RegisterBlock)block
{
    QQButton *button = [QQButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button addTarget:button action:@selector(RegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    button.RegisterBlock = block;
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
- (void)setStatus:(FLAlignmentStatus)status{
    _status = status;
}
- (void)setButtonTopRadio:(CGFloat)buttonTopRadio
{
    if (_buttonTopRadio !=0) {
        _buttonTopRadio = buttonTopRadio;
    }
}
#pragma mark - 左对齐
- (void)alignmentLeft{
    //    获得按钮的文本的frame
    CGRect titleFrame = self.titleLabel.frame;
    //    设置按钮的文本的x坐标为0-－－左对齐
    titleFrame.origin.x = 0;
    //    获得按钮的图片的frame
    CGRect imageFrame = self.imageView.frame;
    //    设置按钮的图片的x坐标紧跟文本的后面
    imageFrame.origin.x = CGRectGetWidth(titleFrame);
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}
#pragma mark - 右对齐
- (void)alignmentRight{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = self.bounds.size.width - fl_imageWidth;
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = imageFrame.origin.x - frame.size.width ;
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}

#pragma mark - 居中对齐
- (void)alignmentCenter{
    //    设置文本的坐标
    CGFloat labelX = (fl_btnWidth - fl_labelWidth -fl_imageWidth - fl_padding) * 0.5;
    CGFloat labelY = (fl_btnHeight - fl_labelHeight) * 0.5;
    
    //    设置label的frame
    self.titleLabel.frame = CGRectMake(labelX, labelY, fl_labelWidth, fl_labelHeight);
    
    //    设置图片的坐标
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + fl_padding;
    CGFloat imageY = (fl_btnHeight - fl_imageHeight) * 0.5;
    //    设置图片的frame
    self.imageView.frame = CGRectMake(imageX, imageY, fl_imageWidth, fl_imageHeight);
}

#pragma mark - 图标在上，文本在下(居中)
- (void)alignmentTop{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageX = (fl_btnWidth - fl_imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, fl_btnHeight * 0.45 - fl_imageHeight * _buttonTopRadio, fl_imageWidth, fl_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, fl_btnHeight * 0.27 + fl_labelHeight * _buttonTopRadio, fl_labelWidth, fl_labelHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}
- (void)alignmentMy
{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageX = (fl_btnWidth - fl_imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, fl_btnHeight * 0.35 - fl_imageHeight * _buttonTopRadio, fl_imageWidth, fl_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, self.imageView.bottom + 10, fl_labelWidth, fl_labelHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}
#pragma mark - 图标在下，文本在上(居中)
- (void)alignmentBottom{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageX = (fl_btnWidth - fl_imageWidth) * 0.5;
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, fl_btnHeight * 0.5 - fl_labelHeight * (1 + fl_buttonBottomRadio), fl_labelWidth, fl_labelHeight);
    
    self.imageView.frame = CGRectMake(imageX, fl_btnHeight * 0.5 , fl_imageWidth, fl_imageHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    // 判断
    if (_status == FLAlignmentStatusNormal) {
        
    }
    else if (_status == FLAlignmentStatusLeft){
        [self alignmentLeft];
    }
    else if (_status == FLAlignmentStatusCenter){
        [self alignmentCenter];
    }
    else if (_status == FLAlignmentStatusRight){
        [self alignmentRight];
    }
    else if (_status == FLAlignmentStatusTop){
        [self alignmentTop];
    }
    else if (_status == FLAlignmentStatusBottom){
        [self alignmentBottom];
    }else{
        [self alignmentMy];
    }
}



- (void)ButtonClick:(QQButton *)button
{
    if (_tempBlock) {
        _tempBlock(button);
    }
}
@end

//@implementation UIButton(DelayResponse)
//
//// 因category不能添加属性，只能通过关联对象的方式。
//static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
//
//- (NSTimeInterval)cs_acceptEventInterval {
//    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
//}
//
//- (void)setCs_acceptEventInterval:(NSTimeInterval)cs_acceptEventInterval {
//    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(cs_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";
//
//- (NSTimeInterval)cs_acceptEventTime {
//
//    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
//}
//
//- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
//    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//
//// 在load时执行hook
//+ (void)load {
//    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method after    = class_getInstanceMethod(self, @selector(cs_sendAction:to:forEvent:));
//    method_exchangeImplementations(before, after);
//}
//
//- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
//    if (!self.cs_acceptEventTime) {
//        self.cs_acceptEventTime = 2;
//    }
//    if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_acceptEventInterval) {
//        return;
//    }
//    
//    if (self.cs_acceptEventInterval > 0) {
//        self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
//    }
//    
//    [self cs_sendAction:action to:target forEvent:event];
//}
//
//@end
