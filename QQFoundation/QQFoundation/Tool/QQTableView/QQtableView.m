//
//  QQtableView.m
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/19.
//  Copyright © 2016年 秦慕乔. All rights reserved.

#import "QQtableView.h"
#import "QQNetManager.h"
#import "MJRefresh.h"
#import "uiview+MB.h"
#import "QQAppDefine.h"
#import "UIView+QQFrame.h"
@interface QQtableView ()
{
    /**纪录当前页数*/
    NSInteger _pageNumber;
    /**下载的网址*/
    NSString *_url;
    /**下载的参数*/
    NSMutableDictionary *_parameters;
    /**添加的footView*/
    UIView *_footerView;
    /**是否启用分页*/
    BOOL _ISPaging;
}
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic, getter=isLoading) BOOL loading;
@end
@implementation QQtableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _isShowStatues = YES;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.estimatedRowHeight  = 0;
            self.estimatedSectionFooterHeight  = 0;
            self.estimatedSectionFooterHeight = 0;
        }
        _footerView  = [[UIView alloc]init];
        [self setTableFooterView:_footerView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style] ) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _footerView  = [[UIView alloc]init];
        [self setTableFooterView:_footerView];
        _isShowStatues = YES;
    }
    return self;
}

- (void)headerRefresh
{
    if (_url.length ==0) {
        NSLog(@"QQTablView:请输入下载网址");
        [self.mj_header endRefreshing];
        return;
    }
    //这里的page要根据后台返回的类型判断
    if (_ISPaging) {
        _pageNumber = [_parameters[@"pageIndex"] integerValue];///<分页中页的参数  页的大小外部传入不做更改
        _pageNumber  = 1;
        [_parameters setObject:[NSNumber numberWithInteger:_pageNumber] forKey:@"pageIndex"];
    }
    [self SetUpNetWorkParamters:_parameters isPullDown:YES];
}
- (void)footerRefresh
{
    if (_ISPaging) {
        _pageNumber = [_parameters[@"pageIndex"] integerValue];
        _pageNumber ++;
        [_parameters setObject:[NSNumber numberWithInteger:_pageNumber] forKey:@"pageIndex"];
    }
    [self SetUpNetWorkParamters:_parameters isPullDown:NO];

}
- (void)SetUpNetWorkParamters:(NSDictionary *)paramters isPullDown:(BOOL)isPullDown
{
    [[QQNetManager defaultManager]RTSTableWith:_url Parameters:paramters From:_TempController Successs:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            if ([self.QQDeleGate respondsToSelector:@selector(QQtableView:isPullDown:SuccessDataArray:)]) {
                [self.QQDeleGate QQtableView:self isPullDown:isPullDown SuccessDataArray:responseObject[@"data"][@"list"]];
            }
            if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]] && [responseObject[@"data"][@"list"] isKindOfClass:[NSArray class]]) {
                 [self.TempController.view Hidden];
                if (isPullDown) {//下啦刷新才会有空白页
                    self.listArray = [NSArray arrayWithArray:responseObject[@"data"][@"list"]];
                    if (self.listArray.count == 0) {
                        self.loadStatuesView.LoadType = QQLoadViewEmpty;
                        self.tableFooterView = self.loadStatuesView;
                    }else{
                        [self setTableFooterView:_footerView];
                    }
                }
             }
        }else{
            /**返回的code码不是200*/
            [self.TempController.view Message:responseObject[@"msg"] HiddenAfterDelay:2];
            [self setTableFooterView:_footerView];
        }
        
        [self EndRefrseh];
    } False:^(NSError *error) {
        if ([self.QQDeleGate respondsToSelector:@selector(QQtableView:requestFailed:)]) {
            [self.QQDeleGate QQtableView:self requestFailed:error];
        }
        if (self.listArray.count == 0) {//只有下拉刷新时候 或者刚开始请求的时候才会是零  保证有数据的时候网络错误也不出现
            self.loadStatuesView.LoadType = QQLoadViewErrornetwork;
            self.tableFooterView = self.loadStatuesView;
        }

        [self.TempController.view Hidden];
        [self EndRefrseh];
        if (!isPullDown) {
            _pageNumber --;///<上啦出现加载失败的时候PageNum恢复到原始参数
            [_parameters setObject:[NSNumber numberWithInteger:_pageNumber] forKey:@"pageIndex"];
        }
        if (error.code == -1001){
            [self.TempController.view Message:@"请求超时，请重试！" HiddenAfterDelay:2];
        }else  if (error.code != -999) {//-999主动取消
            
        }
    }];
}
- (void)EndRefrseh
{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}
- (QQLoadView *)loadStatuesView
{
    if (!_loadStatuesView) {
        _loadStatuesView = [[QQLoadView alloc]init];
        _loadStatuesView.LoadType = QQLoadViewNone;
        self.loadStatuesView.width = self.width;
        self.loadStatuesView.height = self.height  - self.tableHeaderView.height;
        _loadStatuesView.backgroundColor = [UIColor colorWithRed:245 green:248 blue:250 alpha:1];
    }
    return _loadStatuesView;
}
- (void)lazyLaunchWithString:(NSString *)url  Paramerters:(NSDictionary *)paramters FromController:(UIViewController *)controller isPaging:(BOOL)page
{
    if (page) {//是否分页展示 是分页的话就加上拉加载
        self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    }
    _url = url;
    _TempController = controller;
    _parameters= [NSMutableDictionary dictionaryWithDictionary:paramters];
    _ISPaging = page;
}

- (void)setUpWithUrl:(NSString *)url Parameters:(NSDictionary *)Parameters formController:(UIViewController *)controler IsPaging:(BOOL)page
{
    if (page) {//是否分页展示 是分页的话就加上拉加载
        self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    }
    _url = url;
    _TempController = controler;
    _parameters= [NSMutableDictionary dictionaryWithDictionary:Parameters];
    _ISPaging = page;
    [self.mj_header beginRefreshing];
}
@end
