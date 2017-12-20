//
//  QQBaseViewController.h
//  QQFoundation
//
//  Created by Maybe on 2017/12/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQBarItemViewController.h"
#import "QQtableView.h"
#import "QQLoadView.h"
#import "QQNetManager.h"

@interface QQBaseViewController : QQBarItemViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,QQtableViewGate>
@property (copy, nonatomic)NSString *GlobalId;///<每个界面 预留的字符串
@property (nonatomic,strong) id Info;
/**
 *  举个栗子QQController的Nav要透明  就设置QQController的BaseNavBarColor为clearColor
 QQController 用如下代码设置Nav透明   [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
 */
@property (nonatomic,strong)UIColor           *BaseNavBarColor;

@property (strong, nonatomic)UIScrollView     *BaseScrollView;///<基ScrollView
@property (strong, nonatomic)QQtableView      *BaseQQTableView;///<基QQTableView
@property (strong, nonatomic)UITableView      *BaseTableView;///<基TableView
@property (strong, nonatomic)NSMutableArray   *BaseMutableArray;///<基BaseMutableArray
@property (nonatomic,strong) QQLoadView       *BaseLoadView;///<空白界面、网络出错界面等提示界面

/**
 普通的get请求
 
 @param url 请求网址
 @param parameters 请求参数
 */
- (void)RequestGetWith:(NSString *)url Parameters:(NSDictionary *)parameters;


/**
 带有缓存的get请求
 
 @param url 请求的网址
 @param parameters 请求的参数
 */
- (void)RequestGetCacheWith:(NSString *)url Parameters:(NSDictionary *)parameters;


/**
 普通的post请求
 
 @param url 请求的网址
 @param parameters 请求的参数
 */
- (void)RequestPostWith:(NSString *)url Parameters:(NSDictionary *)parameters;


/**
 上传图片
 
 @param url 求轻的网址
 @param parameters 请求的参数
 @param images 图片数组
 */
- (void)RequestUpdateWith:(NSString *)url Parameters:(NSDictionary *)parameters Images:(NSMutableArray *)images;


/**
 获取到请求成功返回的数据
 
 @param response 返回的数据
 @param URL 请求的网址
 */
- (void)getResponseObject:(id)response TagURL:(NSString *)URL;


/**
 获取到请求失败后返回的错误消息
 
 @param err 返回的数据
 @param URL 请求的网址
 */


- (void)getError:(NSError *)err TagURL:(NSString *)URL;


/**
 空白界面的下拉刷新
 */
- (void)QQLoadViewPullRefresh;


/**
 基BaseScroll View的下啦刷新
 */


- (void)ScrollViewPullRefresh;


/**
 基TableView View的下啦刷新
 */
- (void)TableViewPullRefresh;

@end
