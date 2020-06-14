//
//  QQBaseViewController.h
//  QQFoundation
//
//  Created by Maybe on 2017/12/20.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQBarItemViewController.h"
#import "QQtableView.h"
#import "QQTableViewManager.h"
#import "QQNavigationController.h"
@class QQNetManager;
@interface QQBaseViewController : QQBarItemViewController<UIGestureRecognizerDelegate,QQtableViewRequestDelegate,QQNavigationControllerDelegate>


/// 自定义的nav懒加载，使用时先添加到视图上。此nav是界面滑动，动态改变nav颜色及返回按钮
@property (nonatomic,strong)UIView *navBar;

/// 修改nav、返回按钮 、title文字的颜色及显示隐藏
/// @param alpha 传递的透明度值 0～1 小于0为0 大于一为1
- (void)navAlpha:(CGFloat)alpha;

/// 自定义nav返回的点击事件 可在子类重写获取点击事件
- (void)backClick;
@property (strong, nonatomic)QQtableView      *BaseQQTableView;///<基QQTableView
@property (strong, nonatomic)NSMutableArray   *BaseMutableArray;///<基BaseMutableArray
@property (nonatomic , strong) QQTableViewManager * tabManager;
@end
