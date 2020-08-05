//
//  QQDataSoureceItem.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQTableViewSection.h"
@class QQTableViewManager;
@interface QQTableViewItem : NSObject
@property (nonatomic, weak  ) QQTableViewManager *tableViewManager;
@property (nonatomic , strong) QQTableViewSection *section;
/**所处的位置*/
@property (nonatomic, strong) NSIndexPath *indexPath;
/**cell的背景颜色*/
@property (nonatomic , strong) UIColor * bgColor;
/**cel的高度 默认44*/
@property (nonatomic, assign) CGFloat cellHeight;
/**扩展的一个属性字符串0*/
@property (nonatomic, copy) NSString *extendedStr;
/**扩展的一个属性字符串1*/
@property (nonatomic, copy) NSString *extendedStr1;
/**储存正则表达式的属性*/
@property (nonatomic, copy) NSString *regular;

/** 是否是必须项目*/
@property (nonatomic , assign) BOOL  isMust;


/**是否允许策侧滑。默认NO*/
@property (nonatomic, assign) BOOL allowSlide;

/**
//设置单个侧滑。默认是删除
@property (nonatomic, copy  ) NSString *slideText;
*/

/**设置多个策划按钮*/
@property (nonatomic , strong) NSArray * trailingTArray;
/**设置多个策划按钮背景颜色 默认红色*/
@property (nonatomic , strong) NSArray * trailingCArray;

/**设置多个策划按钮*/
@property (nonatomic , strong) NSArray * leadingTArray;
/**设置多个策划按钮背景颜色 默认红色*/
@property (nonatomic , strong) NSArray * leadingCArray;

@property (nonatomic, copy  ) void(^selcetCellHandler)(id item);
@property (nonatomic, copy  ) void(^trailingSwipeHandler)(id item , NSInteger index);
@property (nonatomic, copy  ) void(^leadingSwipeHandler)(id item , NSInteger index);

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;
@end
