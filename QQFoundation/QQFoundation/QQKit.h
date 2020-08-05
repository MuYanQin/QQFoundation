//
//  QQKit.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 Yuan er. All rights reserved.
//

#ifndef QQKit_h
#define QQKit_h
/*************************以下文件是所有项目的头文件 按需获取减少无用的导入***********************************/
///***********************************************************************************
/// Base
///***********************************************************************************

#import "QQNavigationController.h"
#import "QQTabBarController.h"
#import "QQBaseViewController.h"
#import "QQBaseURL.h"
#import "QQAppDefine.h"
#import "MCUserInfo.h"//用户的信息
///***********************************************************************************
///view
///***********************************************************************************
#import "MCPickerView.h"
#import "UIView+MCPopView.h"
#import "QQImagePicker.h"///照片单选 裁剪框自定义大小
#import "QQScanVC.h"///
#import "QQtableView.h"/// 简单的封装数据请求层
#import "QQTableViewManager.h"//TableView视图管理工具
#import "QQAlertcontroller.h"///UIAlertConotrooler的快速使用
#import "MCHoveringView.h"///头部悬浮
#import "MCVerificationCodeView.h"//验证码view
#import "MCPageView.h"//类似新闻类app首页侧滑功能
#import "MCSearchViewController.h"//搜索界面

///***********************************************************************************
///core
///***********************************************************************************
#import "MCHealthManage.h"
#import "NSMutableAttributedString+Manage.h"
#import "NSString+Manage.h"
#import "QQTool.h"///以下简单的小工具
#import "QQDevice.h"//获取系统的一些情况
#import "QQFileManage.h"///获取文件管理  获取地址  创建  等操作
#import "UIScrollView+Touch.h"///解决ScrollView 的滑动与touch事件冲突
#import "UIImage+Usually.h"///
#import "UIView+QQFrame.h"/// 快速获取View的left、right、top、bottom
#import "NSDate+QQCalculate.h"///获取时间日期的一些方法
#import "NSString+QQCalculate.h"///字符串的一些操作
#import "QQButton.h"///
#import "QQTextField.h"/// 最大限制文字数
#import "QQTextView.h"/// 有展位文字、最大限制文字数
#import "UILabel+MCChained.h"//链式语法创建label
#import "UIButton+MCChained.h"//链式语法创建button
#import "MCFactory.h"//工程模式工具
#import "MCPushMediator.h"//push界面的中介者 解耦合->复杂的push关系
#import "MCDownloadManager.h"//下载管理类 ->半成品
//#import "QQSqlHelper.h"//sql工具
#import "QQNetManager.h"/// 封装的AF下载工具  返回取消、同一接口多次请求返回（无响应）
#import "NSObject+MB.h"

#endif /* QQKit_h */
