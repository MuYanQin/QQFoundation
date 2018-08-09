//
//  QQTextField.m
//  sound
//
//  Created by tlt on 16/10/10.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "QQTextField.h"
@implementation QQTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
-(void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}
- (void)initialize
{
    [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    _maxLength = NSUIntegerMax;
    self.delegate = self;
}
- (void)textDidChange:(QQTextField *)TextField
{
    if (_maxLength != NSUIntegerMax) {
        NSString    *toBeString    = TextField.text;
        
        if (!TextField.markedTextRange) {
            if (toBeString.length >_maxLength) {
                TextField.text = [toBeString substringToIndex:_maxLength]; // 截取最大限制字符数.
                [TextField resignFirstResponder];
            }
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (self.openPriceCheck) {
        NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        //匹配以0开头的数字
        NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
        //匹配两位小数、整数
        NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0]).?[0-9]{0,2})$"];
        return ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
    }
    return YES;
}

- (void)dealloc {
}

@end

