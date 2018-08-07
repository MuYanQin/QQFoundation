//
//  QQtableView.m
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/19.
//  Copyright © 2016年 秦慕乔. All rights reserved.

#import "QQtableView.h"
#import "QQNetManager.h"
#import "MJRefresh.h"
#import "UIView+MBProgress.h"
#import "QQAppDefine.h"
#import "UIView+QQFrame.h"
#import "QQTool.h"
#import "MCFactory.h"
static NSString * const pageIndex = @"pageIndex";//获取第几页的
@interface QQtableView ()
{
    /**纪录当前页数*/
    NSInteger _pageNumber;
    /**下载的网址*/
    NSString *_url;
    /**下载的参数*/
    NSMutableDictionary *_parameters;
    /**出现网络失败*/
    BOOL _hasNetError;
    /**底部的文字*/
    UILabel * _textLb;
}
/**添加的footView*/
@property (nonatomic , strong) UIView *footerView;
@end
@implementation QQtableView
+ (void)load
{
    QQ_methodSwizzle(self, @selector(reloadData), @selector(mc_reloadData));
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initTableView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style] ) {
        [self initTableView];
    }
    return self;
}
- (void)initTableView{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.estimatedRowHeight  = 0;
    self.estimatedSectionFooterHeight  = 0;
    self.estimatedSectionFooterHeight = 0;
    _hasNetError = NO;
    [self setTableFooterView:self.footerView];
    _isShowStatues = YES;
}
- (void)mc_reloadData
{
    [self mc_reloadData];
    if (self.getTotal == 0) {
        self.loadStatuesView.LoadType = QQLoadViewEmpty;
    }else if (self.getTotal == 0 && _hasNetError){
        self.loadStatuesView.LoadType = QQLoadViewErrornetwork;
    }else{
        [self setTableFooterView:self.footerView];
    }
    self.tableFooterView = self.isShowStatues ? self.loadStatuesView: self.footerView;
}
- (NSInteger)getTotal
{
    
    NSInteger sections = 0;
    
    sections = [self numberOfSections];
    NSInteger items = 0;
    for (NSInteger section = 0; section < sections; section++) {
        items += [self numberOfRowsInSection:section];
    }
    return items;
}
- (void)setUpWithUrl:(NSString *)url Parameters:(NSDictionary *)Parameters formController:(UIViewController *)controler
{
    _url = url;
    _TempController = controler;
    _parameters= [NSMutableDictionary dictionaryWithDictionary:Parameters];
    self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self.mj_header beginRefreshing];
}
//**请求方法*/
- (void)SetUpNetWorkParamters:(NSDictionary *)paramters isPullDown:(BOOL)isPullDown
{
    [[QQNetManager defaultManager]RTSTableWith:_url Parameters:paramters From:_TempController Successs:^(id responseObject) {
        //不管有没有数据都应该抛出去
        if ([self.QQDeleGate respondsToSelector:@selector(QQtableView:isPullDown:SuccessDataArray:)]) {
            [self.QQDeleGate QQtableView:self isPullDown:isPullDown SuccessDataArray:responseObject[@"data"][@"list"]];
        }
        [self.TempController.view hiddenHUD];
        if (![responseObject[@"code"] isEqualToString:@"200"]) {
            /**返回的code码不是200*/
            [self.TempController.view message:responseObject[@"msg"] HiddenAfterDelay:2];
        }
        _hasNetError = NO;
        [self EndRefrseh];
    } False:^(NSError *error) {
        _hasNetError = YES;
        [self.TempController.view hiddenHUD];
        if ([self.QQDeleGate respondsToSelector:@selector(QQtableView:requestFailed:)]) {
            [self.QQDeleGate QQtableView:self requestFailed:error];
        }
        [self EndRefrseh];
        if (!isPullDown) {
            [self changeIndexWithStatus:3];
        }
        if (error.code == -1001){
            [self.TempController.view message:@"请求超时，请重试！" HiddenAfterDelay:2];
        }else  if (error.code != -999) {//-999主动取消
            
        }
    }];
}
- (void)setIsHasHeaderRefresh:(BOOL)isHasHeaderRefresh
{
    if (!isHasHeaderRefresh) {
        self.mj_header = nil;
    }
}
- (void)headerRefresh
{
    if (_url.length ==0) {
        NSLog(@"QQTablView:请输入下载网址");
        [self.mj_header endRefreshing];
        return;
    }
    [self changeIndexWithStatus:1];
    [self SetUpNetWorkParamters:_parameters isPullDown:YES];
}
- (void)footerRefresh
{
    [self changeIndexWithStatus:2];
    [self SetUpNetWorkParamters:_parameters isPullDown:NO];
}
- (void)changeIndexWithStatus:(NSInteger)Status//1  下拉  2上拉  3减一
{
    _pageNumber = [_parameters[pageIndex] integerValue];
    if (Status == 1) {
        _pageNumber = 1;
    }else if (Status == 2){
        _pageNumber ++;
    }else{
        _pageNumber --;
    }
    [_parameters setObject:[NSNumber numberWithInteger:_pageNumber] forKey:pageIndex];
}
- (void)EndRefrseh
{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}
- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 5)];
//        _textLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.width, 20)];
//        _textLb.textAlignment = NSTextAlignmentCenter;
//        _textLb.textColor = getColorWithHex(@"2c2c2c");
//        _textLb.font = getFontRegular(15);
//        [_footerView addSubview:_textLb];
    }
    return _footerView;
}

- (QQLoadView *)loadStatuesView
{
    if (!_loadStatuesView) {
        _loadStatuesView = [[QQLoadView alloc]init];
        _loadStatuesView.LoadType = QQLoadViewNone;
        self.loadStatuesView.width = self.width;
        //设置view的高度是TableView 的高度减去TableHeaderView的高度
        self.loadStatuesView.height = self.height  - self.tableHeaderView.height;
        _loadStatuesView.backgroundColor = [UIColor colorWithRed:245 green:248 blue:250 alpha:1];
    }
    return _loadStatuesView;
}
@end
