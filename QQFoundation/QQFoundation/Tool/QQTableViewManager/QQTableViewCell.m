//
//  QQTableViewCell.m
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTableViewCell.h"
#import "QQTableViewItem.h"
@implementation QQTableViewCell

- (void)cellDidLoad{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.item.bgColor) {
        self.contentView.backgroundColor  = self.item.bgColor;
    }
}
- (void)cellWillAppear{
    
}
- (void)cellDidDisappear{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
