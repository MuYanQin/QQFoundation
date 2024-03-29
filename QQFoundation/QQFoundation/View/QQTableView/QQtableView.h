//
//  QQtableView.h
//  QQNetManager
//
//  Created by Yuan er on 16/4/19.
//  Copyright © 2016年 Yuan er. All rights reserved.
//
#import <UIKit/UIKit.h>
@class QQtableView,EmptyView;
@protocol QQtableViewRequestDelegate <NSObject>
@optional
/**
 返回请求到的数据
 @param QQtableView 返回自己
 @param pullDown   返回bool 表明  YES－－下拉刷新  NO －－－ 上拉记载
 @param successData         返回的数据
 */
- (void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)pullDown successData:(id)successData;

/**
 返回网络错误的状态

 @param QQtableView self
 @param error 错误error
 */
@optional
- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error;

@end

@interface QQtableView : UITableView<UIGestureRecognizerDelegate>
@property (weak,nonatomic) id<QQtableViewRequestDelegate> requestDelegate;
//配合MCHoveringView使用的属性 在QQTableViewManager中被调用。MCHoveringView使用/
//**获取tableView偏移量的Block*/
@property (nonatomic , copy) void(^scrollViewDidScroll)(UIScrollView * scrollView);

//配合MCHoveringView使用的属性/
/**是否同时响应多个手势 默认NO*/
@property (nonatomic , assign) BOOL  canResponseMutiGesture;

/*传递controller进来展示loadding状态只能是weak不会引用*/
@property (weak, nonatomic)UIViewController *tempController;


/**
 空白页、网络错误页  页面的内容可用此属性去更改
 */
@property (nonatomic , strong)  EmptyView * emptyView;

/**
 是否有头部刷新  默认YES
 */
@property (nonatomic,assign) BOOL hasHeaderRefresh;

/**
 获取总的Item
 */
@property (nonatomic , assign) NSInteger  getTotal;

/**
 请求的网址
 */
@property (nonatomic , copy) NSString * requestUrl;

/**
 请求的参数
 */
@property (nonatomic , strong) NSMutableDictionary * requestParam;


/**开始刷新 可在这里修改请求的参数*/
@property (nonatomic , copy) void(^begainRefresh)(BOOL headRefresh,QQtableView *tableView);

/**结束刷新*/
@property (nonatomic , copy) void(^endRefresh)(BOOL headRefresh,QQtableView *tableView);

/**
 开始数据请求任务。需要设置requestParam、requestUrl 不可以下拉刷新
 */
- (void)requestData;

/**
 开始数据请求任务 可以下拉刷新。如包含分页参数 亦可上拉
 @param url        请求的网址
 @param param 携带的参数 （一定要把分页参数放在这里）
 */
- (void)networkStart:(NSString *)url param:(NSDictionary *)param formVc:(UIViewController *)vc;

@end

/***************************  以下是空白界面的View  **************************************************/
@interface EmptyView : UIView

/**
 图片名称
 */
@property (nonatomic , copy) NSString * imageName;
/**
 默认图片大小显示居中
 */
@property (nonatomic , assign) CGSize  imageSize;

/**
 提示文字
 */
@property (nonatomic , copy) NSString * hintText;

/**
 提示文字字体
 */
@property (nonatomic , strong) UIFont * hintTextFont;

/**
 提示文字颜色
 */
@property (nonatomic , strong) UIColor * hintTextColor;

/**
 提示文字富文本
 */
@property (nonatomic , strong) NSAttributedString * hintAttributedText;
@end

