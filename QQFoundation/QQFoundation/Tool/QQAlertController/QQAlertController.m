//
//  QQAlertController.m
//  QQFoundation
//
//  Created by Maybe on 2018/1/23.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQAlertController.h"
#import "DefaultAnimation.h"
#import "UIView+QQFrame.h"
@interface QQAlertController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *cancelText;
@property (nonatomic, copy) NSString *buttonText;
@property (nonatomic, copy) NSString *descriptionText;

@property (nonatomic, copy) void (^buttonAction)(NSInteger index);

@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *descriptionLabel;
@property (strong, nonatomic)  UIButton *cancelButton;
@property (strong, nonatomic)  UIButton *button;
@property (strong, nonatomic)  UIView *verticalLineView;
@end

@implementation QQAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title description:(NSString *)description cancel:(NSString *)cancel button:(NSString *)button action:(void (^)(NSInteger index))buttonAction
{
    NSAssert(title.length > 0 || description.length > 0 , @"title和description不能同时为空");
    
    QQAlertController *alert = [[QQAlertController alloc] init];
    alert.transitioningDelegate = alert;
    alert.modalPresentationStyle = UIModalPresentationCustom;
    alert.titleText = title;
    alert.descriptionText = description;
    alert.cancelText = cancel ? cancel : @"取消";
    alert.buttonText = button;
    alert.buttonAction = buttonAction;
    
    return alert;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.isTouchHidden){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.view addGestureRecognizer:tap];
    }
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5];
    [self initUI];
}
- (void)initUI
{
    [self.view addSubview:self.AlertView];
    [self.AlertView addSubview:self.titleLabel];
    [self.AlertView addSubview:self.descriptionLabel];
    [self.AlertView addSubview:self.cancelButton];
    [self.AlertView addSubview:self.button];
    
    self.titleLabel.text = self.titleText;
    self.descriptionLabel.text = self.descriptionText;
    [self.cancelButton setTitle:self.cancelText forState:UIControlStateNormal];
    [self.button setTitle:self.buttonText forState:UIControlStateNormal];
    
    CGFloat titleHeight = [self.titleLabel sizeThatFits:CGSizeMake(230, 0)].height;
    CGFloat descHeight = [self.descriptionLabel sizeThatFits:CGSizeMake(230, 0)].height;
    CGFloat offset = 0.0;//内容偏移量
    if (titleHeight == 0.0) {
        offset = - 20;
    }
    if (descHeight == 0.0) {
        offset += -25;
    }
    self.titleLabel.frame = CGRectMake(20, 35, 230, titleHeight);
    self.descriptionLabel.frame = CGRectMake(20, self.titleLabel.bottom + 20 + offset, 230, descHeight);
    self.cancelButton.frame = CGRectMake(20, self.descriptionLabel.bottom + 25, 107, 40);
    self.button.frame = CGRectMake(self.cancelButton.right + 15, self.descriptionLabel.bottom + 25, 107, 40);
    
    CGFloat AlertHeight = 35 + titleHeight + 20 + descHeight + 25 + 40 + 30 + offset;
    self.AlertView.frame = CGRectMake((self.view.width - 270)/2,(self.view.height - AlertHeight)/2, 270, AlertHeight);
}
- (void)SureClick
{
    if (self.buttonAction) {
        self.buttonAction(1);
    }
}
- (void)cancelClick
{
    if ([self.cancelButton.titleLabel.text isEqualToString:@"取消"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if (self.buttonAction) {
            self.buttonAction(0);
        }
    }
}
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(SureClick) forControlEvents:UIControlEventTouchUpInside];
        _button.backgroundColor = [UIColor yellowColor];
    }
    return _button;
}
- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.backgroundColor = [UIColor cyanColor];
    }
    return _cancelButton;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]init];
        _descriptionLabel.textColor = [UIColor lightGrayColor];
        _descriptionLabel.font = [UIFont systemFontOfSize:14];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.numberOfLines = 0;
    }
    return _descriptionLabel;
}
- (UIView *)AlertView
{
    if (!_AlertView) {
        _AlertView = [[UIView alloc]initWithFrame:CGRectMake((self.view.width - 270)/2, (self.view.height - 110)/2, 270, 110)];
        _AlertView.backgroundColor = [UIColor whiteColor];
        _AlertView.layer.cornerRadius = 5;
        _AlertView.layer.masksToBounds = YES;
    }
    return _AlertView;
}
- (void)tap{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UIViewControllerTransitioningDelegate --

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[DefaultAnimation alloc] init];

}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DefaultAnimation alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
