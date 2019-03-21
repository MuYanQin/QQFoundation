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

@interface QQBaseViewController ()
@property (nonatomic,strong)UIView *navBar;
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
    //这里的色值与 Nav的色值相同
    self.BaseNavBarColor = self.navigationController.view.backgroundColor;
    [self.view addSubview:self.navBar];
}
//nav透明的使用
#pragma mark -- Setter & Getter
- (UIView *)navBar {
    if (_navBar == nil) {
        _navBar = [[UIView alloc] init];
        _navBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
        _navBar.alpha = 0.0;
    }
    return _navBar;
}
- (void)setBaseNavBarColor:(UIColor *)BaseNavBarColor
{
    self.navBar.backgroundColor = BaseNavBarColor;
    self.navBar.alpha = 1.0;
    [self.view bringSubviewToFront:self.navBar];
}
#pragma mark - 数据请求的众多方法
- (void)RequestGetWith:(NSString *)url Parameters:(NSDictionary *)parameters{
    [[QQNetManager Instance] RTSGetWith:url parameters:parameters from:self successs:^(id responseObject) {
        [self getTempResponseObject:responseObject TagURL:url];
    } failed:^(NSError *error) {
        [self getTempError:error TagURL:url];
    }];
}
- (void)RequestGetCacheWith:(NSString *)url Parameters:(NSDictionary *)parameters
{
    [[QQNetManager Instance] RTSGetWith:url parameters:parameters from:self successs:^(id responseObject) {
        [self getTempResponseObject:responseObject TagURL:url];
    } failed:^(NSError *error) {
        [self getTempError:error TagURL:url];
    }];
}
- (void)RequestPostWith:(NSString *)url Parameters:(NSDictionary *)parameters
{
    [[QQNetManager Instance]RTSPostWith:url parameters:parameters from:self successs:^(id responseObject) {
        [self getTempResponseObject:responseObject TagURL:url];
    } failed:^(NSError *error) {
        [self getTempError:error TagURL:url];
    }];
}
- (void)RequestUpdateWith:(NSString *)url Parameters:(NSDictionary *)parameters Images:(NSMutableArray *)images
{
    [[QQNetManager Instance]RTSUploadWith:url parameters:parameters imageArray:images from:self fileMark:@"" progress:^(NSProgress *uploadProgress) {
        
    } success:^(id responseObject) {
        
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - 数据请求之后的中间方法

/**
 中间函数  直接用getError：TagURl： 会被重写的
 */
- (void)getTempError:(NSError *)error TagURL:(NSString *)URL{
    
    //    error.code == -1009;///<offline 断网
    [self getError:error TagURL:URL];
    
}
- (void)getTempResponseObject:(id)response TagURL:(NSString *)URL {
    
    //这里要判断是不是为空
    [self getResponseObject:response TagURL:URL];
}

#pragma mark - 最终获取到数据的内容

- (void)getResponseObject:(id)response TagURL:(NSString *)URL {
    
}
- (void)getError:(NSError *)err TagURL:(NSString *)URL {

}
#pragma mark - 基类里面的一些属性
- (QQtableView *)BaseQQTableView
{
    if (!_BaseQQTableView) {
        _BaseQQTableView = [[QQtableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 44)];
        _BaseQQTableView.RequestDelegate = self;
        _BaseQQTableView.estimatedRowHeight = 0;
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
#pragma mark - 基类的下拉刷新方法
/**
 *  修改状态颜色 需要在自定义的nav里同时修改
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
