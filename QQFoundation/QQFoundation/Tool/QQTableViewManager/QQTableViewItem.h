//
//  QQDataSoureceItem.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QQTableViewItem : NSObject
@property (nonatomic, assign) CGFloat CellHeight;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *indexPath ;
@property (copy  , nonatomic) void(^CellSelcetHandler)(id item);

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;
@end
