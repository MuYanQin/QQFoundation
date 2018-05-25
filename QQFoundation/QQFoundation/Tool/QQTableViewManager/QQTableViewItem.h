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
@property (nonatomic, assign) CGFloat CellHeight;
@property (nonatomic, weak  ) QQTableViewManager *tableViewManager;
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 是否允许策侧滑。默认NO
 */
@property (nonatomic, assign) BOOL allowSlide;
@property (nonatomic , strong) UIColor * bgColor;
/**
 侧滑展示的文字。默认是删除
 */
@property (nonatomic, copy  ) NSString *slideText;
@property (nonatomic, copy  ) void(^CellSelcetHandler)(id item);
@property (nonatomic, copy  ) void(^CellSlideHandler)(id item);

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;
@end
