//
//  QQTextField.m
//  sound
//
//  Created by tlt on 16/10/10.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "QQTextField.h"
#import "UIView+SuperViewController.h"
#import "UIView+MBProgress.h"
@implementation QQTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)initialize
{
    [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    _maxLength = NSUIntegerMax;
    
}
-(void)awakeFromNib {
    [super awakeFromNib];
    [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    _maxLength = NSUIntegerMax;
}
- (void)textDidChange:(QQTextField *)TextField
{
    if (_maxLength != NSUIntegerMax) {
        NSString    *toBeString    = TextField.text;
        
        if (!TextField.markedTextRange) {
            if (toBeString.length >_maxLength) {
                TextField.text = [toBeString substringToIndex:_maxLength]; // 截取最大限制字符数.
                [self.viewController.view Message:[NSString stringWithFormat:@"最不能超过%lu个字符",(unsigned long)_maxLength] HiddenAfterDelay:2];
                [TextField resignFirstResponder];
            }
        }
    }
    
}
@end

