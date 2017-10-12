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
#import "UIScrollView+EmptyDataSet.h"
#import "QQLoadView.h"
#import "QQAppDefine.h"
@interface QQtableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSInteger _pageNumber;///<纪录当前处于哪个
    NSString *_url;///<下载的网址
    NSMutableDictionary *_parameters;///<下载的参数
    UIView *_footerView;///<添加的footView
    BOOL _ISPaging;///<是否启用分页
    
}
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic,strong)     QQLoadView * myLoadView;

@end
@implementation QQtableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

//        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//        // 设置普通状态的动画图片
//        [header setImages:@[[UIImage imageNamed:@"1"]] forState:MJRefreshStateIdle];
//        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//        [header setImages:@[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]] forState:MJRefreshStatePulling];
//        // 设置正在刷新状态的动画图片
//        [header setImages:@[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]] forState:MJRefreshStateRefreshing];
//        // 设置header
//        self.mj_header = header;//
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//        MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
//        
//        // 设置普通状态的动画图片
//        [footer setImages:@[[UIImage imageNamed:@"1"]] forState:MJRefreshStateIdle];
//        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//        [footer setImages:@[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]] forState:MJRefreshStatePulling];
//        // 设置正在刷新状态的动画图片
//        [footer setImages:@[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]] forState:MJRefreshStateRefreshing];
//        
//        // 设置尾部
//        self.mj_footer = footer;
        if (VERSION >=11) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.estimatedRowHeight  = 0;
            self.estimatedSectionFooterHeight  = 0;
            self.estimatedSectionFooterHeight = 0;
        }
        _footerView  = [[UIView alloc]init];
        [self setTableFooterView:_footerView];
//        _spaceView = [[QQSpaceView alloc]init];
        //注册通知取消刷新状态
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
- (void)setIsOpenEmptyDataSet:(BOOL)IsOpenEmptyDataSet
{
    _IsOpenEmptyDataSet = IsOpenEmptyDataSet;
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
    [[QQNetManager defaultManager]RTSTableWith:_url Parameters:_parameters From:_TempController Successs:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            //如果下载的数据源数组为空则开始 展现空白页
            if ([self IsNull:responseObject[@"rst"]] ||([responseObject[@"rst"] count] ==0)) {
                if (_IsOpenEmptyDataSet) {
                    self.emptyDataSetSource = self;
                    self.emptyDataSetDelegate =self;
                }
            }
            if ([self.QQDeleGate respondsToSelector:@selector(QQtableView:isPullDown:SuccessDataDic:)]) {
                [self.QQDeleGate QQtableView:self isPullDown:YES SuccessDataDic:responseObject];
            }
            [self.TempController.view Hidden];
        }else{
            [self.TempController.view Message:responseObject[@"msg"] HiddenAfterDelay:2];
        }
        [self.mj_header endRefreshing];
    } False:^(NSError *error) {
        [self.TempController.view Hidden];
        [self.mj_header endRefreshing];
        if (error.code == -1001){
            [self.TempController.view Message:@"请求超时，请重试！" HiddenAfterDelay:2];
            
        }else  if (error.code != -999) {
            [self.TempController.view Hidden];
            //非主动取消链接
//            [[QQNetManager defaultManager] showProgressHUDWithType:0];
            [_TempController.view addSubview:self.myLoadView];
            self.myLoadView.LoadViewType = QQLoadViewErrornetwork;
            __weak  typeof(self)  WeakSelf = self;
            self.myLoadView.clickblock = ^(){
                [WeakSelf headerRefresh];
            };
        }
    }];
}
//基类的空白页
- (QQLoadView *)myLoadView
{
    if (! _myLoadView) {
        _myLoadView = [[QQLoadView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
        _myLoadView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    }
    return _myLoadView;
}
- (void)footerRefresh
{
    if (_ISPaging) {
        _pageNumber = [_parameters[@"pageIndex"] integerValue];
        _pageNumber ++;
        [_parameters setObject:[NSNumber numberWithInteger:_pageNumber] forKey:@"pageIndex"];
    }
    [[QQNetManager defaultManager]RTSTableWith:_url Parameters:_parameters From:_TempController Successs:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            if ([self IsNull:responseObject[@"rst"]] ||([responseObject[@"rst"] count] ==0)) {
                [self.TempController.view Message:@"暂无更多数据" HiddenAfterDelay:2];
            }
            if ([self.QQDeleGate respondsToSelector:@selector(QQtableView:isPullDown:SuccessDataDic:)]) {
                [self.QQDeleGate QQtableView:self isPullDown:NO SuccessDataDic:responseObject];
                [self.TempController.view Hidden];
            }
        }else{
            [self.TempController.view Message:responseObject[@"msg"] HiddenAfterDelay:2];
        }
        [self.mj_footer endRefreshing];

    } False:^(NSError *error) {
        _pageNumber --;///<上啦出现加载失败的时候PageNum恢复到原始参数
        [_parameters setObject:[NSNumber numberWithInteger:_pageNumber] forKey:@"pageIndex"];
        [self.TempController.view Hidden];
        
        [self.mj_footer endRefreshing];
        if (error.code == -1001){
            [self.TempController.view Message:@"请求超时，请重试！" HiddenAfterDelay:2];
            
        }else  if (error.code != -999) {
            [self.TempController.view Hidden];
            //非主动取消链接
            [[QQNetManager defaultManager] showProgressHUDWithType:0];
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

- (void)UpDate
{
    [self.mj_header beginRefreshing];
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    text = @"No Messages";
    font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0];
    textColor = [UIColor cyanColor];
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    text = @"When you have messages, you’ll see them here.";
    font = [UIFont systemFontOfSize:13.0];
    textColor = [UIColor purpleColor];
    paragraph.lineSpacing = 4.0;
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{

    return [UIImage imageNamed:@""];
}
//点击后的动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    text = @"Continue";
    font = [UIFont boldSystemFontOfSize:17.0];
    textColor = [UIColor redColor];
    
    
    if (!text) {
        return nil;
    }
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{

    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsZero;

    capInsets = UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0);
    rectInsets = UIEdgeInsetsMake(0.0, 10, 0.0, 10);

    
    return [[[UIImage imageNamed:@""] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0.0;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 24.0;
}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
//    self.loading = YES;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
    [self.mj_header beginRefreshing];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
//    self.loading = YES;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
    [self.mj_header beginRefreshing];

}



@end
