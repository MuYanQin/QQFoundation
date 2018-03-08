//
//  QQtableView.h
//  QQNetManager
//
//  Created by 秦慕乔 on 16/4/19.
//  Copyright © 2016年 秦慕乔. All rights reserved.
//
//李密码的空白界面可 自己写
#import <UIKit/UIKit.h>
@class QQtableView;
@protocol QQtableViewGate <NSObject>

/**
 QQTableView的代理

 @param QQtableView 返回自己
 @param direction   返回bool 表明  YES－－下拉刷新  NO －－－ 上拉记载
 @param dic         返回的数据
 */
- (void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)direction SuccessDataDic:(NSDictionary *)dic;

- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error;

@end
@interface QQtableView : UITableView
@property (assign,nonatomic) id<QQtableViewGate> QQDeleGate;
@property (weak, nonatomic)UIViewController *TempController;///<传递controller进来展示loadding状态只能是weak不会引用

/**
 直接开始下载任务

 @param url        请求的网址
 @param Parameters 携带的参数 （一定要有，把分页参数放在这里）
 @param page       是否是分页
 */
- (void)setUpWithUrl:(NSString *)url Parameters:(NSDictionary *)Parameters formController:(UIViewController *)controler IsPaging:(BOOL)page;
/**
 参数先传进去  之后在手动开始开始下载
 
 @param url        url description
 @param paramters  paramters description
 @param page       page description
 */
- (void)lazyLaunchWithString:(NSString *)url  Paramerters:(NSDictionary *)paramters FromController:(UIViewController *)controller isPaging:(BOOL)page;

@end
