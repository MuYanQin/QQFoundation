//
//  QQTextView.m
//  Teacher
//
//  Created by tlt on 16/11/4.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "QQTextView.h"
#import "UIView+SuperViewController.h"
#import "UIView+MBProgress.h"
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@implementation QQTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    _maxLength = NSUIntegerMax;
    // 设置默认字体
    self.font = [UIFont systemFontOfSize:12];
    
    // 设置默认颜色
    self.placeholderColor = RGB(200, 199, 204);
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    _maxLength = NSUIntegerMax;
    // 设置默认字体
    self.font = [UIFont systemFontOfSize:12];
    
    // 设置默认颜色
    self.placeholderColor = RGB(200, 199, 204);
}
- (void)textDidChange:(NSNotification *)notification
{
    if (_maxLength != NSUIntegerMax) {
        NSString    *toBeString    = self.text;
        
        if (!self.markedTextRange) {
            if (toBeString.length >_maxLength) {
                self.text = [toBeString substringToIndex:_maxLength]; // 截取最大限制字符数.
                [self.viewController.view Message:[NSString stringWithFormat:@"最不能超过%lu个字符",_maxLength] HiddenAfterDelay:2];
                [self resignFirstResponder];
            }
        }
    }
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 * 每次调用drawRect:方法，都会将以前画的东西清除掉
 */
- (void)drawRect:(CGRect)rect
{
    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;
    
    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}
@end
