//
//  QQTextField.m
//  sound
//
//  Created by tlt on 16/10/10.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "QQTextField.h"
#import "UIView+SuperViewController.h"
#import "uiview+MB.h"
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    _maxLength = NSUIntegerMax;

}
-(void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    _maxLength = NSUIntegerMax;
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


}
@end
