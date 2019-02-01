//
//  ArtileImageCell.m
//  medicalConsultDoctor
//
//  Created by qinmuqiao on 2018/9/16.
//  Copyright © 2018年 MuYaQin. All rights reserved.
//

#import "ArtileImageCell.h"

@implementation ArtileImageCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setUpAllChildView];
    }
    return self;
}
- (void)setUpAllChildView
{
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    
    self.button = [QQButton buttonWithType:UIButtonTypeCustom];
    self.button.QimageSize(CGSizeMake(15, 15)).QtextPosition(Tright);
    [self.button setImage:[UIImage imageNamed:@"MCDEleteItem"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
- (void)buttonClick:(QQButton *)button
{
    if (self.deleteImage) {
        self.deleteImage([button.info integerValue]);
    }
}
@end
