//
//  QQDataSoureceItem.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class QQTableViewManager;
@interface QQTableViewItem : NSObject
/**cel的高度 默认44*/
@property (nonatomic, assign) CGFloat CellHeight;
@property (nonatomic, weak  ) QQTableViewManager *tableViewManager;
/**所处的位置*/
@property (nonatomic, strong) NSIndexPath *indexPath;
/**cell的背景颜色*/
@property (nonatomic , strong) UIColor * bgColor;
/**是否允许策侧滑。默认NO*/
@property (nonatomic, assign) BOOL allowSlide;
/**设置单个侧滑。默认是删除*/
@property (nonatomic, copy  ) NSString *slideText;
/**设置多个策划按钮*/
@property (nonatomic , strong) NSArray * slideTextArray;
/**设置多个策划按钮背景颜色*/
@property (nonatomic , strong) NSArray * slideColorArray;

@property (nonatomic, copy  ) void(^selcetCellHandler)(id item);
@property (nonatomic, copy  ) void(^slideCellHandler)(id item);

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;
@end
