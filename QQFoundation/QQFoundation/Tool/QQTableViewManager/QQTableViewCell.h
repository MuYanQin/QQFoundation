//
//  QQTableViewCell.h
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQTableViewItem.h"
@interface QQTableViewCell : UITableViewCell
@property (nonatomic, strong) QQTableViewItem *item;


- (void)cellDidLoad;
- (void)cellWillAppear;
- (void)cellDidDisappear;
@end
