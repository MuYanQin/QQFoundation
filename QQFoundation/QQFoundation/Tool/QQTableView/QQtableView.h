//
//  QQtableView.h
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/19.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QQLoadView.h"
@class QQtableView,EmptyView;
@protocol QQtableViewRequestDelegate <NSObject>

/**
 返回请求到的数据
 @param QQtableView 返回自己
 @param PullDown   返回bool 表明  YES－－下拉刷新  NO －－－ 上拉记载
 @param SuccessData         返回的数据
 */
- (void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)PullDown SuccessData:(id)SuccessData;


/**
 返回网络错误的状态

 @param QQtableView self
 @param error 错误error
 */
- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error;

@end

@interface QQtableView : UITableView
@property (assign,nonatomic) id<QQtableViewRequestDelegate> RequestDelegate;

/*传递controller进来展示loadding状态只能是weak不会引用*/
@property (weak, nonatomic)UIViewController *TempController;

/**空白页、网络错误页  页面的内容可用此属性去更改*/
@property (nonatomic , strong)  EmptyView * emptyView;

/*是否有头部刷新  默认YES  */
@property (nonatomic,assign) BOOL isHasHeaderRefresh;

/**获取总的Item*/
@property (nonatomic , assign) NSInteger  getTotal;


//**开始刷新*/
- (void)headerRefresh;

/**
 开始下载任务  网络数据用此开始  本地数据则不用使用本方法 用法同系统的UITableView

 @param url        请求的网址
 @param Parameters 携带的参数 （一定要有，把分页参数放在这里）
 */
- (void)setUpWithUrl:(NSString *)url Parameters:(NSDictionary *)Parameters formController:(UIViewController *)controler;

@end

/***************************  以下是空白界面的View  **************************************************/
@interface EmptyView : UIView
@property (nonatomic , copy) NSString * imageName;
/**
 默认图片大小显示居中
 */
@property (nonatomic , assign) CGSize  imageSize;
@property (nonatomic , copy) NSString * hintText;
@end

















