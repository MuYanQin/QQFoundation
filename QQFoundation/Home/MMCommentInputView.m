//
//  MMCommentInputView.m
//  MomentKit
//
//  Created by LEA on 2019/3/25.
//  Copyright © 2019 LEA. All rights reserved.
//

#import "MMCommentInputView.h"
CGFloat const MMContainMinHeight = 50;

CGFloat const BtnWitdh = 80;
// 容器最大高度
CGFloat const MMContainMaxHeight = 120;
// 容器减去输入框的高度
CGFloat const MarginHeight = 15;


@interface MMCommentInputView () <UITextViewDelegate>

// 容器视图
@property (nonatomic, strong) UIView * containView;
// 输入框
@property (nonatomic, strong) UITextView * textView;
// 表情按钮
@property (nonatomic, strong) UIButton * emoticonBtn;
// 记录容器高度
@property (nonatomic, assign) CGFloat ctHeight;
// 记录上一次容器高度
@property (nonatomic, assign) CGFloat previousCtHeight;
// 键盘高度
@property (nonatomic, assign) CGFloat keyboardHeight;

@end

@implementation MMCommentInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        // 容器视图
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, MMContainMinHeight)];
        view.backgroundColor = getColor(248, 248, 248);
        [self addSubview:view];
        self.containView = view;
        // -- 分割线
        CALayer * layer = [CALayer layer];
        layer.backgroundColor = getColor(230, 230, 230).CGColor;
        layer.frame = CGRectMake(0, 0, KScreenWidth, 0.5);
        [view.layer addSublayer:layer];
        
        // 行间距
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        // attributes
        NSDictionary * textAttributes = @{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:14]};
        // 输入框
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(15, MarginHeight/2.0, KScreenWidth - (BtnWitdh + 15), MMContainMinHeight - MarginHeight)];
        textView.backgroundColor = [UIColor whiteColor];
        textView.enablesReturnKeyAutomatically = YES;
        textView.showsVerticalScrollIndicator = NO;
        textView.showsHorizontalScrollIndicator = NO;
        textView.layer.cornerRadius = 4;
        textView.layer.masksToBounds = YES;
        textView.font = [UIFont systemFontOfSize:16.0];
        textView.textContainerInset = UIEdgeInsetsMake(7, 7, 7, 7);
        textView.typingAttributes = textAttributes;

        textView.delegate = self;
        textView.textColor = [UIColor blackColor];
        [self.containView addSubview:textView];
        self.textView = textView;
        
        // 表情按钮
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - BtnWitdh + 7, MarginHeight/2, BtnWitdh -15, MMContainMinHeight - MarginHeight)];
        btn.backgroundColor = getColor(248, 220, 61);
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"发送" forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(sendMsg) forControlEvents:(UIControlEventTouchUpInside)];
        btn.titleLabel.font  = [UIFont systemFontOfSize:16];
        [self.containView addSubview:btn];
        self.emoticonBtn = btn;
        
        self.ctTop = 0;
        self.keyboardHeight = 0;
        self.ctHeight = 0;
        self.previousCtHeight = 0;
        // 键盘监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    return self;
}

#pragma mark - 键盘监听
- (void)keyboardFrameChange:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = ([[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 ) | UIViewAnimationOptionBeginFromCurrentState;
    // 键盘高度
    CGFloat keyboardH = 0;
    if (endFrame.origin.y == [[UIScreen mainScreen] bounds].size.height) { // 弹下
        keyboardH = 0;
    } else {
        keyboardH = endFrame.size.height;
    }
    self.keyboardHeight = keyboardH;
    // 容器的top
    CGFloat top = 0;
    if (keyboardH > 0) {
        top = KScreenHeight - self.containView.height - self.keyboardHeight;
    } else {
        top = KScreenHeight;
    }
    self.ctTop = top;
    // 动画
    [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
        self.containView.top = top;
    } completion:^(BOOL finished) {
        if (keyboardH == 0) {
            self.textView.text = nil;
            [self removeFromSuperview];
        }
    }];
    // 监听键盘高度
    if (self.MMContainerWillChangeFrameBlock) {
        self.MMContainerWillChangeFrameBlock(self.keyboardHeight);
    }
}

#pragma mark - 更新容器高度
- (void)containViewDidChange:(CGFloat)ctHeight
{
    
    ctHeight = ctHeight + MarginHeight;
    if (ctHeight < MMContainMinHeight || self.textView.attributedText.length == 0){
        ctHeight = MMContainMinHeight;
    }
    self.textView.scrollEnabled = NO;
    if (ctHeight > MMContainMaxHeight) {
        ctHeight = MMContainMaxHeight;
        self.textView.scrollEnabled = YES;
    }
    if (ctHeight == self.previousCtHeight) {
        return;
    }
    self.previousCtHeight = ctHeight;
    self.ctHeight = ctHeight;
    self.ctTop = KScreenHeight - ctHeight - self.keyboardHeight;
    // 更新UI
    [UIView animateWithDuration:0.25 animations:^{
        // 容器
        self.containView.height = ctHeight;
        self.containView.top = self.ctTop;
        // 输入框
        self.textView.height = ctHeight - MarginHeight;
        // 表情按钮
        self.emoticonBtn.top = ctHeight - self.emoticonBtn.height - MarginHeight/2;
    }];
    // 监听容器高度
    if (self.MMContainerWillChangeFrameBlock) {
        self.MMContainerWillChangeFrameBlock(self.keyboardHeight);
    }
}

#pragma mark - YYTextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    [self containViewDidChange:[textView sizeThatFits:CGSizeMake(KScreenWidth - (BtnWitdh + 15), 0)].height];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){ // 回车
//        // 监听输入文本
//        if (self.MMCompleteInputTextBlock) {
//            self.MMCompleteInputTextBlock(textView.text);
//        }
//        textView.text = @"";
//        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)sendMsg
{
    if (self.MMCompleteInputTextBlock) {
        self.MMCompleteInputTextBlock(self.textView.text);
    }
    self.textView.text = @"";
    [self.textView resignFirstResponder];
}
#pragma mark - UIResponder
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    if (CGRectContainsPoint(self.containView.frame, currentPoint) == NO) {
        [self.textView resignFirstResponder];
    }
}

#pragma mark - 显示
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.textView becomeFirstResponder];
}

#pragma mark -
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
