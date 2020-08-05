//
//  MCVerificationCodeView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/9.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCVerificationCodeView.h"
#define PWD_COUNT 6
@interface MCVerificationCodeView()
@property (strong, nonatomic)UITextField *pwdTextField;
@property (strong,nonatomic)NSMutableArray *pwdIndicatorArr;
@property (strong,nonatomic)NSMutableArray *pwdTextArr;
@end
@implementation MCVerificationCodeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self  initUI];
    }
    return self;
}
- (void)initUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    
    self.pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.pwdTextField.hidden = YES;
    self.pwdTextField.delegate = self;
    [self.pwdTextField becomeFirstResponder];
    self.pwdTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.pwdTextField.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    [self addSubview:self.pwdTextField];
    
    self.pwdIndicatorArr = [[NSMutableArray alloc]init];
    self.pwdTextArr = [[NSMutableArray alloc]init];
    
    
    CGFloat DOT_WIDTH = self.frame.size.width /PWD_COUNT;
    for (int i = 0; i < PWD_COUNT; i ++) {
        UILabel *dot = [[UILabel alloc]initWithFrame:CGRectMake(DOT_WIDTH *i, 0, DOT_WIDTH, self.frame.size.height)];
        dot.textAlignment = NSTextAlignmentCenter;
        dot.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        [self addSubview:dot];
        
        [self.pwdIndicatorArr addObject:dot];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(2, dot.frame.size.height -1,dot.frame.size.width - 4,1)];
        line.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.];
        [dot addSubview:line];
    }
}
- (void)tap
{
    [self.pwdTextField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length >= PWD_COUNT && string.length) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    if (range.length ==0) {
        if (_isSecret) {
            [self.pwdTextArr addObject:@"●"];//●●•
        }else{
            [self.pwdTextArr addObject:string];
        }
        
    }else{
        [self.pwdTextArr removeLastObject];
    }
    [self setDotWithCount:totalString.length];
    
    NSLog(@"==== %@",totalString);
    if (totalString.length == PWD_COUNT) {
        if (self.completeHandle) {
            self.completeHandle(totalString);
        }
    }
    return YES;
    
}
- (void)setDotWithCount:(NSInteger)count {
    for (UILabel *dot in self.pwdIndicatorArr) {
        dot.text = @"";
    }
    for (int i = 0; i< count; i++) {
        UILabel *label =(UILabel*)[self.pwdIndicatorArr objectAtIndex:i];
        label.text = self.pwdTextArr[i];
    }
}
- (void)setIsSecret:(BOOL)isSecret
{
    _isSecret = isSecret;
}
@end
