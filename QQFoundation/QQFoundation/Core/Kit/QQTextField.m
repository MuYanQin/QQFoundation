//
//  QQTextField.m
//  sound
//
//  Created by tlt on 16/10/10.
//  Copyright © 2016年 tlt. All rights reserved.
//

#import "QQTextField.h"
#import "UIView+QQFrame.h"
@interface QQTextField ()
@property (nonatomic , strong) UILabel * label;
@end

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
    _maxLength = NSUIntegerMax;
    self.delegate = self;
    [self addTarget:self action:@selector(textDidChange:) forControlEvents:(UIControlEventEditingChanged)];
}
- (void)textDidChange:(QQTextField *)textField
{
    if (self.textDidChange) {
        self.textDidChange(textField.text);
    }
    
    if (_maxLength != NSUIntegerMax) {
        if (!textField.markedTextRange) {
            if (textField.text.length >_maxLength) {
                textField.text = [textField.text substringToIndex:_maxLength];
            }
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (self.openPriceCheck) {
        //放置移动光标输入的文字插入错误
        NSMutableString *str = [[NSMutableString alloc]initWithString:textField.text];
        [str insertString:string atIndex:range.location];
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

