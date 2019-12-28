//
//  MCAuthorSecView.m
//  QQFoundation
//
//  Created by leaduMac on 2019/12/28.
//  Copyright © 2019 慕纯. All rights reserved.
//

#import "MCAuthorSecView.h"

@implementation MCAuthorSecItem

@end

@implementation MCAuthorSecView

- (void)secViewDidLoad
{
    [super secViewDidLoad];
    self.backgroundColor = [UIColor purpleColor];
    self.contLabel = [[UILabel alloc]init];
    self.contLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.contLabel];
    
    [self.contLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
}
- (void)secViewWillAppear
{
    self.contLabel.text = self.item.text;
}

@end
