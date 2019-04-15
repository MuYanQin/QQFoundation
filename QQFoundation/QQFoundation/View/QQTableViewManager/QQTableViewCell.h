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


/**
 cell加载的方法
 */
- (void)cellDidLoad;

/**
 cell将要出现 这里添加数据
 */
- (void)cellWillAppear;

/**
 cell将要出屏幕
 */
- (void)cellDidDisappear;

/**
 自适应高度 子类重写即可

 @return cel的高度
 */
- (CGFloat)autoCellHeight;

- (void)setHighlighted:(BOOL)highlighted;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
@end
