//
//  QQBaseViewController.m
//  QQFoundation
//
//  Created by Maybe on 2017/12/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQBaseViewController.h"
#import "QQAppDefine.h"
#import "MJRefresh.h"
#import "QQNetManager.h"
#import "MCFactory.h"
#import "UILabel+MCChained.h"
@interface QQBaseViewController ()
@property (nonatomic , strong) QQButton *backButton;
@property (nonatomic , strong) UILabel *titleLb;
@end

@implementation QQBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //关闭透明度
    //iOS11中舍弃了automaticallyAdjustsScrollViewInsets  "Use UIScrollView's contentInsetAdjustmentBehavior instead
    if (VERSION <11) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
//MARK:滑动消失隐藏
- (UIView *)navBar {
    if (_navBar == nil) {
        _navBar = [[UIView alloc] init];
        _navBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, MCNavHeight);
        _navBar.backgroundColor = [UIColor clearColor];
        _backButton = [QQButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.QbgClolor([UIColor whiteColor]).QcornerRadius(18).Qtarget(self, @selector(backClick));
        [self.navBar addSubview:_backButton];
        
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left_back"]];
        [_backButton addSubview:img];
        
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.navBar).offset(8);
            make.centerY.equalTo(self.navBar).offset(11);
            make.size.mas_equalTo(CGSizeMake(36, 36));
        }];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(_backButton);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        _titleLb = [UILabel getLabel].Qfont(18).Qtext(self.title).QtextColor([UIColor clearColor]);
        [_navBar addSubview:_titleLb];
        
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_backButton);
            make.centerX.equalTo(_navBar);
        }];
        
    }
    return _navBar;
}
- (void)backClick{
    [self.navigationController popViewControllerAnimated: YES];
}
- (void)navAlpha:(CGFloat)alpha{
    self.navBar.backgroundColor = [self.navigationController.navigationBar.barTintColor colorWithAlphaComponent:alpha];
    self.backButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:(1-alpha)];
    self.titleLb.textColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
}
#pragma mark - 基类里面的一些属性
- (QQtableView *)BaseQQTableView
{
    if (!_BaseQQTableView) {
        if (self.buildGroupTab) {
            _BaseQQTableView = [[QQtableView alloc]initWithFrame:CGRectMake(0, MCNavHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - MCNavHeight - MCBottomDistance) style:(UITableViewStyleGrouped)];
            _BaseQQTableView.backgroundColor = [UIColor purpleColor];
            
        }else{
            _BaseQQTableView = [[QQtableView alloc]initWithFrame:CGRectMake(0, MCNavHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - MCNavHeight - MCBottomDistance) style:(UITableViewStylePlain)];
        }
        _BaseQQTableView.RequestDelegate = self;
    }
    return _BaseQQTableView;
}
- (QQTableViewManager *)tabManager
{
    if (!_tabManager) {
        [self.view addSubview:self.BaseQQTableView];
        _tabManager = [[QQTableViewManager alloc]initWithTableView:self.BaseQQTableView];
    }
    return _tabManager;
}
//基类的数组
- (NSMutableArray *)BaseMutableArray
{
    if (!_BaseMutableArray) {
        _BaseMutableArray  = [NSMutableArray array];
    }
    return _BaseMutableArray;
}
/**
 *  修改状态颜色 需要在自定义的nav里同时修改
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
    
}
@end
