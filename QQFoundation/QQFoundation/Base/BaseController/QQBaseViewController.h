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

@property (nonatomic,assign) BOOL buildGroupTab;
/**
 *  举个栗子QQController的Nav要透明  就设置QQController的BaseNavBarColor为clearColor
 QQController 用如下代码设置Nav透明   [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
 */
@property (nonatomic,strong)UIView *navBar;
- (void)navAlpha:(CGFloat)alpha;
@property (strong, nonatomic)QQtableView      *BaseQQTableView;///<基QQTableView
@property (strong, nonatomic)NSMutableArray   *BaseMutableArray;///<基BaseMutableArray
@property (nonatomic , strong) QQTableViewManager * tabManager;
@end
