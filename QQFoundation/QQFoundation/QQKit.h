//
//  QQKit.h
//  QQUIKit
//
//  Created by tlt on 17/3/15.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#ifndef QQKit_h
#define QQKit_h
///***********************************************************************************
/// Base
///***********************************************************************************

#import "QQNavigationController.h"
#import "QQTabBarController.h"
#import "BaseViewController.h"
#import "QQBaseURL.h"
#import "QQAppDefine.h"
///***********************************************************************************
/// Category
///***********************************************************************************
#import "NSMutableAttributedString+Manage.h"
#import "NSString+Manage.h"
#import "NSAttributedString+Easy.h"/// 一些AttibutedString的快速使用
#import "NSDate+QQCalculate.h"///获取时间日期的一些方法
#import "NSString+QQCalculate.h"///字符串的一些操作
#import "UIButton+Cache.h"///为了防止中间更换其他的图片下载工具
#import "UIImage+Usually.h"///
#import "UIImageView+Cache.h"///
#import "UIScrollView+Touch.h"///解决ScrollView 的滑动与touch事件冲突
#import "UIView+MBProgress"
#import "UIView+QQFrame.h"/// 快速获取View的left、right、top、bottom
#import "UIView+SuperViewController.h"///获取View的父Controller
#import "UIView+MCPopView"//快捷的弹出视图分类

///***********************************************************************************
/// Successor
///***********************************************************************************
#import "CALayer+XibConfiguration.h"///nib文件设置button的边框
#import "QQButton.h"///
#import "QQDevice.h"//获取系统的一些情况
#import "QQFileManage.h"///获取文件管理  获取地址  创建  等操作
#import "QQLabel.h"///<可点击的label
#import "QQLoadView.h"//空白页、加载出错页
#import "QQTextField.h"/// 最大限制文字数
#import "QQTextView.h"/// 有展位文字、最大限制文字数
#import "QQDateFormatter.h"//Cache  formatter
#import "SHTextView.h"///仿QQ的聊天文字输入框 的自增长
///***********************************************************************************
/// Tool
///***********************************************************************************
#import "MCPushMediator.h"//push界面的中介者 解耦合->复杂的push关系
#import "MCDownloadManager.h"//下载管理类 ->半成品
#import "MCPageView.h"//类似新闻类app首页侧滑功能
#import "QQAlertcontroller.h"///UIAlertConotrooler的快速使用
#import "QQSqlHelper.h"//sql工具
#import "QQScanVC.h"/// 
#import "QQNetManager.h"/// 封装的AF下载工具  返回取消、同一接口多次请求返回（无响应）
#import "QQImagePicker.h"///照片单选 裁剪框自定义大小
#import "QQtableView.h"/// 简单的封装数据请求层
#import "QQTableViewManager.h"//TableView视图管理工具
#import "QQTool.h"///以下简单的小工具 一些文件操作   获取app的一些信息   后期要分离
#endif /* QQKit_h */
