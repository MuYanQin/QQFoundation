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
}
- (void)textDidChange:(QQTextField *)TextField
{

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (_maxLength != NSUIntegerMax) {
        NSMutableString *str = [[NSMutableString alloc]initWithString:textField.text];
        [str insertString:string atIndex:range.location];
        if (!textField.markedTextRange) {
            if (str.length >_maxLength) {
//                [self showErrorText];
                return NO;
            }
        }
    }
    
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
/**
- (void)setErrorText:(NSString *)errorText
{
    _errorText = errorText;
    self.label.text = _errorText;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    if (textAlignment == NSTextAlignmentLeft) {
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.height.mas_equalTo(10);
            make.top.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
        }];
    }else if (textAlignment == NSTextAlignmentRight){
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.height.mas_equalTo(10);
            make.top.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
        }];
    }
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.font = [UIFont systemFontOfSize:12 weight:(UIFontWeightRegular)];
        _label.textColor = [UIColor redColor];
        _label.hidden = YES;
        [self addSubview:_label];


    }
    return _label;
}
 */
- (void)showErrorText
{
    if (!_label.isHidden) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _label.hidden = NO;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _label.hidden = YES;
        });
    }];
}
- (void)dealloc {
}

@end

