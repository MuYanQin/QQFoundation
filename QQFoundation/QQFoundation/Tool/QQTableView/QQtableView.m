//
//  QQtableView.m
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/19.
//  Copyright © 2016年 秦慕乔. All rights reserved.

#import "QQtableView.h"
#import "QQNetManager.h"
#import "MJRefresh.h"
static NSString * const pageIndex = @"pageIndex";//获取第几页的根据自己的需求替换
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
}
/**添加的footView*/
@property (nonatomic , strong) UIView *footerView;
@end
@implementation QQtableView
+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(mc_reloadData));
    BOOL didAddMethod =
    class_addMethod(self,
                    @selector(reloadData),
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            @selector(mc_reloadData),
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
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
    [self setTableFooterView:self.footerView];
    _hasNetError = NO;
}
- (void)mc_reloadData
{
    [self mc_reloadData];
    if (!self.footerView) {
        self.footerView = self.tableFooterView;
    }
    if (self.getTotal == 0) {
        self.tableFooterView = self.emptyView;
    }else if (self.getTotal == 0 && _hasNetError){
        self.tableFooterView =  self.emptyView;
    }else{
        [self setTableFooterView:self.footerView];
    }
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
    
#warning 这里替换成自己的网络请求方法就好了 
    [[QQNetManager Instance]RTSGetWith:_url Parameters:paramters From:_TempController Successs:^(id responseObject) {
        //不管有没有数据都应该抛出去
        if ([self.RequestDelegate respondsToSelector:@selector(QQtableView:isPullDown:SuccessData:)]) {
            [self.RequestDelegate QQtableView:self isPullDown:isPullDown SuccessData:responseObject];
        }
        _hasNetError = NO;
        [self EndRefrseh];
    } False:^(NSError *error) {
        _hasNetError = YES;
        if ([self.RequestDelegate respondsToSelector:@selector(QQtableView:requestFailed:)]) {
            [self.RequestDelegate QQtableView:self requestFailed:error];
        }
        [self EndRefrseh];
        if (!isPullDown) {
            [self changeIndexWithStatus:3];
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
- (EmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]init];
        _emptyView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.tableHeaderView.frame.size.height);
        _emptyView.backgroundColor = [UIColor colorWithRed:245/255.0f green:248/255.0f blue:250/255.0f alpha:1];
    }
    return _emptyView;
}
@end


/***************************  以下是空白界面的View  **************************************************/
@interface EmptyView ()
@property (nonatomic , strong) UILabel * hintLb;
@property (nonatomic , strong) UIImageView * imageView;
@end
@implementation EmptyView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initEmptyView];
    }
    return self;
}
- (void)initEmptyView
{
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_em_al"]];
    [self.imageView sizeToFit];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.imageView];
    
    self.hintLb = [[UILabel alloc]init];
    self.hintLb.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.hintLb.textColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
    self.hintLb.text = @"暂时还没有数据哦0.0";
    [self.hintLb setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.hintLb.textAlignment = NSTextAlignmentCenter;
    self.hintLb.numberOfLines = 0;
    [self addSubview:self.hintLb];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.6 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hintLb attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hintLb attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hintLb attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:-20]];

}
- (void)setImageSize:(CGSize)imageSize
{
    _imageSize = imageSize;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:imageSize.width]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:imageSize.height]];
}
- (void)setHintText:(NSString *)hintText
{
    self.hintLb.text = hintText;
}
- (void)setImageName:(NSString *)imageName
{
    self.imageView.image = [UIImage imageNamed:imageName];
}
@end











