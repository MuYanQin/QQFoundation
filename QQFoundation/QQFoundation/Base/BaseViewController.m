//
//  BaseViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "BaseViewController.h"
#import "QQAppDefine.h"
#import "MJRefresh.h"
//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0
//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface BaseViewController ()
@property (nonatomic,strong)UIView *navBar;
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //关闭透明度
    self.navigationController.navigationBar.translucent = YES ;
    //iOS11中舍弃了automaticallyAdjustsScrollViewInsets  "Use UIScrollView's contentInsetAdjustmentBehavior instead
    if (VERSION <11) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//这里的色值与 Nav的色值相同
    self.BaseNavBarColor = self.navigationController.view.backgroundColor;
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.BaseLoadView];
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
    [[QQNetManager defaultManager] RTSGetWith:url Parameters:parameters From:self Successs:^(id responseObject) {
        [self getTempResponseObject:responseObject TagURL:url];
    } False:^(NSError *error) {
        [self getTempError:error TagURL:url];
    }];
}
- (void)RequestGetCacheWith:(NSString *)url Parameters:(NSDictionary *)parameters
{
    [[QQNetManager defaultManager]RTSGetCacheWith:url Parameters:parameters From:self Successs:^(id responseObject) {
        [self getTempResponseObject:responseObject TagURL:url];
    } False:^(NSError *error) {
        [self getTempError:error TagURL:url];
    }];
}
- (void)RequestPostWith:(NSString *)url Parameters:(NSDictionary *)parameters
{
    [[QQNetManager defaultManager]RTSPostWith:url Parameters:parameters From:self Successs:^(id responseObject) {
        [self getTempResponseObject:responseObject TagURL:url];
    } False:^(NSError *error) {
        [self getTempError:error TagURL:url];
    }];
}
- (void)RequestUpdateWith:(NSString *)url Parameters:(NSDictionary *)parameters Images:(NSMutableArray *)images
{
    [[QQNetManager defaultManager]RTSUploadWith:url Dictionary:parameters MutableArray:images From:self Progress:^(NSProgress *uploadProgress) {
    } Success:^(id responseObject) {
        [self getTempResponseObject:responseObject TagURL:url];
    } False:^(NSError *error) {
        [self getTempError:error TagURL:url];
    }];
}

#pragma mark - 数据请求之后的中间方法

/**
 中间函数  直接用getError：TagURl： 会被重写的
 */
- (void)getTempError:(NSError *)error TagURL:(NSString *)URL{
    
    [self.view addSubview:self.BaseLoadView];
    self.BaseLoadView.LoadViewType = QQLoadViewErrornetwork;
    
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
//基类scroll
- (UIScrollView *)BaseScrollView
{
    if (!_BaseScrollView) {
        _BaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
        _BaseScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(ScrollViewPullRefresh)];

    }
    return _BaseScrollView;
}
//
- (QQtableView *)BaseQQTableView
{
    if (!_BaseQQTableView) {
        _BaseQQTableView = [[QQtableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
        _BaseQQTableView.delegate = self;
        _BaseQQTableView.dataSource = self;
        _BaseQQTableView.QQDeleGate = self;
    }
    return _BaseQQTableView;
}
- (UITableView *)BaseTableView
{
    if (!_BaseTableView) {
        _BaseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
        _BaseTableView.delegate = self;
        _BaseTableView.dataSource = self;
        _BaseTableView.estimatedRowHeight  = 0;
        _BaseTableView.estimatedSectionFooterHeight  = 0;
        _BaseTableView.estimatedSectionFooterHeight = 0;
        _BaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(TableViewPullRefresh)];
    }
    return _BaseTableView;
}

//基类的数组
- (NSMutableArray *)BaseMutableArray
{
    if (!_BaseMutableArray) {
        _BaseMutableArray  = [NSMutableArray array];
    }
    return _BaseMutableArray;
}
//基类的空白页
- (QQLoadView *)BaseLoadView
{
    if (! _BaseLoadView) {
        _BaseLoadView = [[QQLoadView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
        _BaseLoadView.backgroundColor = [UIColor whiteColor];
        _BaseLoadView.LoadViewType = QQLoadViewNone;
        __block QQLoadView *QQL = _BaseLoadView;
        _BaseLoadView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(QQLoadViewPullRefresh)];
        _BaseLoadView.clickblock = ^{
            [QQL.mj_header beginRefreshing];
        };
    }
    return _BaseLoadView;
}
#pragma mark - 基类的下拉刷新方法
//scroll的下拉刷新方法
- (void)ScrollViewPullRefresh
{
}
//传统tableview的下啦刷新方法
- (void)TableViewPullRefresh
{

}
//空白页的下拉刷新方法
- (void)QQLoadViewPullRefresh
{

}
/**
 *  修改状态颜色 需要在自定义的nav里同时修改
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  返回取消渲染的image
 */
- (UIImage *)removeRendering:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
