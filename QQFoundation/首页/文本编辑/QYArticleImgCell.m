//
//  QYArticleImgCell.m
//  QQFoundation
//
//  Created by leaduMac on 2020/8/7.
//  Copyright © 2020 慕纯. All rights reserved.
//

#import "QYArticleImgCell.h"
@implementation QYArticleImgItem


@end
@implementation QYArticleImgCell
@synthesize item = _item;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        [self addSubview:self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
    }
    return self;
}
- (void)cellWillAppear
{
    [super cellWillAppear];
    self.imgView.image = self.item.image;
}
@end
