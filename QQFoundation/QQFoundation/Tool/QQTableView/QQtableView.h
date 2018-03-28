//
//  QQtableView.h
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/19.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QQLoadView.h"
@class QQtableView;
@protocol QQtableViewGate <NSObject>

/**
 QQTableView的代理

 @param QQtableView 返回自己
 @param PullDown   返回bool 表明  YES－－下拉刷新  NO －－－ 上拉记载
 @param DataArray         返回的数据
 */
- (void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)PullDown SuccessDataArray:(NSArray *)DataArray;


/**
 返回网络错误的状态

 @param QQtableView self
 @param error 错误error
 */
- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error;

@end

@interface QQtableView : UITableView
@property (assign,nonatomic) id<QQtableViewGate> QQDeleGate;

/*传递controller进来展示loadding状态只能是weak不会引用*/
@property (weak, nonatomic)UIViewController *TempController;

/**空白页、网络错误页  页面的内容可用此属性去更改*/
@property (nonatomic,strong)     QQLoadView *loadStatuesView;
/*是否展示空白界面  默认YES  展示*/
@property (nonatomic,assign) BOOL isShowStatues;

//**开始刷新*/
- (void)headerRefresh;

/**
 开始下载任务  网络数据用此开始  本地数据则不用使用本方法 用法同系统的UITableView

 @param url        请求的网址
 @param Parameters 携带的参数 （一定要有，把分页参数放在这里）
 */
- (void)setUpWithUrl:(NSString *)url Parameters:(NSDictionary *)Parameters formController:(UIViewController *)controler;

@end
