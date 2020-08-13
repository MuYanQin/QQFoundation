//
//  QQTableViewCell.m
//  QQFoundation
//
//  Created by 李金龙 on 2018/5/24.
//  Copyright © 2018年 MuYanQin. All rights reserved.
//

#import "QQTableViewCell.h"
@implementation QQTableViewCell

- (void)cellDidLoad{
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)cellWillAppear{
    if (self.item.bgColor) {
        self.contentView.backgroundColor  = self.item.bgColor;
    }
}
- (void)cellDidDisappear{
    
}
- (CGFloat)autoCellHeight{
    return self.item.cellHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
}
@end
