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
@interface QQtableView ()
{
    NSInteger _pageNumber;///<纪录当前处于哪个
    NSString *_url;///<下载的网址
    NSMutableDictionary *_parameters;///<下载的参数
    UIView *_footerView;///<添加的footView
    BOOL _ISPaging;///<是否启用分页
    
}
@property (nonatomic, getter=isLoading) BOOL loading;
@end
@implementation QQtableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
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
            //如果下载的数据源数组为空则开始 展现空白页
            if ([self IsNull:responseObject[@"rst"]] ||([responseObject[@"rst"] count] ==0)) {
                
            }
            if ([self.QQDeleGate respondsToSelector:@selector(QQtableView:isPullDown:SuccessDataDic:)]) {
                [self.QQDeleGate QQtableView:self isPullDown:isPullDown SuccessDataDic:responseObject];
            }
            [self.TempController.view Hidden];
        }else{
            [self.TempController.view Message:responseObject[@"msg"] HiddenAfterDelay:2];
        }
        [self EndRefrseh];
    } False:^(NSError *error) {
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
- (BOOL)IsNull:(id)data
{
    BOOL bret = NO;
    if (data == nil) {
        bret = YES;
    }else if (data ==NULL){
        bret = YES;
    }else if ([data isEqual:[NSNull null]]){
        bret = YES;
    }else if ([data isKindOfClass:[NSNull class]]){
        bret = YES;
    }
    return bret;
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
