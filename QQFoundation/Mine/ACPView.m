//
//  ACPView.m
//  QQFoundation
//
//  Created by leaduMac on 2019/5/28.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import "ACPView.h"
#import "UILabel+MCChained.h"
@interface ACPView ()
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) UIView *prov;
@property (nonatomic , strong) UILabel *tishiLb;
@property (nonatomic , strong) UILabel *oneLb;
@property (nonatomic , strong) UILabel *twoLb;
@property (nonatomic , strong) UILabel *threeLb;
@property (nonatomic , strong) UILabel *fourLb;
@property (nonatomic , strong) UILabel *fiveLb;
@property (nonatomic , strong) QQButton *rightBtn;

@property (nonatomic , assign) CGFloat  maxV;
@end

@implementation ACPView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    self.rightBtn = [QQButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.Qtext(@"0.03 空气清晰").Qfont(12).QborderColor([UIColor purpleColor])
    .QcornerRadius(8).QmasksToBounds(YES);
    [self addSubview:self.rightBtn];
    
    self.bgView = getView([UIColor purpleColor]);
    [self addSubview:self.bgView];
    
    self.prov = getView([UIColor redColor]);
    [self addSubview:self.prov];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(70, 16));
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.rightBtn.mas_left).offset(-10);
        make.height.mas_equalTo(16);
    }];
    
    [self.prov mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(16);
    }];
    
    self.tishiLb = [UILabel getLabel].Qfont(12).QtextColor([UIColor purpleColor]);
    [self addSubview:self.tishiLb];
    
    [self.tishiLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(5);
    }];
    CGFloat width = (KScreenWidth - 10 -10 -10 -70)/4;
    self.oneLb = [UILabel getLabel].Qfont(12).QtextColor([UIColor purpleColor]);
    [self addSubview:self.oneLb];
    
    self.twoLb = [UILabel getLabel].Qfont(12).QtextColor([UIColor purpleColor]);
    [self addSubview:self.twoLb];
    
    self.threeLb = [UILabel getLabel].Qfont(12).QtextColor([UIColor purpleColor]);
    [self addSubview:self.threeLb];
    
    self.fourLb = [UILabel getLabel].Qfont(12).QtextColor([UIColor purpleColor]);
    [self addSubview:self.fourLb];
    
    self.fiveLb = [UILabel getLabel].Qfont(12).QtextColor([UIColor purpleColor]);
    [self addSubview:self.fiveLb];
    
    [self.oneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_left);
        make.top.equalTo(self.bgView.mas_bottom);
    }];
    
    [self.twoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_left).offset(width);
        make.top.equalTo(self.bgView.mas_bottom);
    }];
    
    [self.threeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_left).offset(2*width);
        make.top.equalTo(self.bgView.mas_bottom);
    }];
    
    [self.fourLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_left).offset(3*width);
        make.top.equalTo(self.bgView.mas_bottom);
    }];
    
    [self.fiveLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_left).offset(4*width);
        make.top.equalTo(self.bgView.mas_bottom);
    }];
}
- (void)setShuzhi:(CGFloat)shuzhi
{
    CGFloat width = (KScreenWidth - 10 -10 -10 -70);
    CGFloat tt = width*shuzhi/self.maxV;
    [self.prov mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(tt);
    }];
    
//    [self.prov mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self).offset(10);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(tt);
//    }];
}
- (void)setDataArr:(NSArray *)dataArr
{
    self.oneLb.text = dataArr[0];
    self.twoLb.text = dataArr[1];
    self.threeLb.text = dataArr[2];
    self.fourLb.text = dataArr[3];
    self.fiveLb.text = dataArr[4];
    self.maxV = [dataArr[4] floatValue];
}
- (void)setRightText:(NSString *)rightText
{
    self.rightBtn.Qtext(rightText);
}
- (void)setProText:(NSString *)proText
{
    self.tishiLb.text = proText;
}
@end
