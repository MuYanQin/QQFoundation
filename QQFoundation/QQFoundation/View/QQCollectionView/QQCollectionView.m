//
//  QQCollectionView.m
//  QQFoundation
//
//  Created by leaduMac on 2020/6/8.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "QQCollectionView.h"
#import "MJRefresh.h"
#import "QQNetManager.h"
static NSString * const pageIndex = @"pageNum";//获取第几页的根据自己的需求替换

@implementation QQCollectionView
{
    /**纪录当前页数*/
    NSInteger _pageNumber;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initCollectionView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initCollectionView];
    }
    return self;
}
- (void)initCollectionView{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
- (void)netWorkStart:(NSString *)url param:(NSDictionary *)param vc:(UIViewController *)controller{
    _requestUrl = url;
    _tempController = controller;
    _requestParam = param.mutableCopy;
    if ([param.allKeys containsObject:pageIndex]) {
        self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    }
    [self.mj_header beginRefreshing];
}
- (void)requestData
{
    if (self.requestUrl.length ==0) {
        NSLog(@"QQTablView:请输入下载网址");
        [self.mj_header endRefreshing];
        return;
    }
    if ([_requestParam.allKeys containsObject:pageIndex]) {
        [self changeIndexWithStatus:1];
    }
    [self setUpNetWorkParamters:_requestParam isPullDown:YES];
}

- (void)footerRefresh
{
    [self changeIndexWithStatus:2];
    [self setUpNetWorkParamters:_requestParam isPullDown:NO];
}
- (void)changeIndexWithStatus:(NSInteger)Status//1  下拉  2上拉  3减一
{
    _pageNumber = [_requestParam[pageIndex] integerValue];
    if (Status == 1) {
        _pageNumber = 1;
    }else if (Status == 2){
        _pageNumber ++;
    }else{
        _pageNumber --;
    }
    [_requestParam setValue:@"10" forKey:@"pageSize"];
    [_requestParam setObject:[NSNumber numberWithInteger:_pageNumber] forKey:pageIndex];
}
//**请求方法*/
- (void)setUpNetWorkParamters:(NSDictionary *)paramters isPullDown:(BOOL)isPullDown
{
    
    [[QQNetManager Instance] RTSPostJsonWith:_requestUrl parameters:paramters from:_tempController successs:^(id responseObject) {
        if ([self.requestDelegate respondsToSelector:@selector(QQCollectionView:isPullDown:successData:)]) {
            [self.requestDelegate QQCollectionView:self isPullDown:isPullDown successData:responseObject[@"data"]];
        }
        [self endRefrseh];
    } failed:^(NSError *error) {
        if ([self.requestDelegate respondsToSelector:@selector(QQCollectionView:requestFailed:)]) {
            [self.requestDelegate QQCollectionView:self requestFailed:error];
        }
        [self endRefrseh];
        if (!isPullDown) {
            [self changeIndexWithStatus:3];
        }
    }];

}
- (void)endRefrseh
{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return self.canResponseMutiGesture;
}
@end
