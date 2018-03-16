//
//  QQLoadView.m
//  QQUIKit
//
//  Created by ZhangQun on 2017/3/29.
//  Copyright © 2017年 秦慕乔. All rights reserved.
//

#import "QQLoadView.h"
#import "UIColor+Hexadecimal.h"
#import "UIView+QQFrame.h"
#import "MJRefresh.h"

@interface QQLoadView ()
/**中间的图片*/
@property (strong, nonatomic)UIImageView *ImageView ;
/**中间大一点的提示文字*/
@property (nonatomic,strong) UILabel *showLabel;
/**下面小一点的字体*/
@property (nonatomic,strong) UILabel *deatilLabel;
@end

@implementation QQLoadView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame]) {
        _LoadType = QQLoadViewNone;
        self.backgroundColor = [UIColor colorWithHexString:@"F5F8FA"];
        [self initParameters];
    }
    return self;
}
- (void)initParameters
{
    self.ImageView = [[UIImageView alloc]init];
    _ImageView.image = [UIImage imageNamed:@"404-3"];
    _ImageView.userInteractionEnabled = YES;
    [self addSubview:_ImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick)];
    [_ImageView addGestureRecognizer:tap];
    
    _showLabel = [[UILabel alloc]init];
    _showLabel.font = [UIFont systemFontOfSize:14];
    _showLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_showLabel];
    
    _deatilLabel = [[UILabel alloc]init];
    _deatilLabel.font = [UIFont systemFontOfSize:12];
    _deatilLabel.textAlignment = NSTextAlignmentCenter;
    _deatilLabel.hidden = YES;
    _deatilLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:_deatilLabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _ImageView.frame = CGRectMake((self.width - 117)/2,137, 117, 100);
    _showLabel.frame = CGRectMake(self.width/2 - 150, _ImageView.bottom + 20, 300, 20);
    _deatilLabel.frame = CGRectMake(self.width/2 - 50, _showLabel.bottom + 20, 100, 20);
}
- (void)setLoadType:(QQLoadViewType)LoadType
{
    _LoadType = LoadType;
    switch (LoadType) {
        case QQLoadViewNone:
        {
            self.hidden = YES;
            [self.superview sendSubviewToBack:self];
            break;
        }
        case QQLoadViewEmpty:
        {
            _ImageView.userInteractionEnabled = NO;
            _ImageView.image = [UIImage imageNamed:@"icon_em_al"];
//            _deatilLabel.text = @"下拉刷新";
            _showLabel.text = @"暂无数据";
            self.hidden = NO;
            [self.superview bringSubviewToFront:self];
            break;
        }
        case QQLoadViewErrornetwork:
        {
            _ImageView.image = [UIImage imageNamed:@"multi_network_error_icon@2x"];
//            _deatilLabel.text = @"点击或者下拉刷新";
            _showLabel.text = @"网络连接错误，点击图片重新加载";
            self.hidden = NO;
            [self.superview bringSubviewToFront:self];
            break;
        }
        default:
            break;
    }
}
- (void)setImageName:(NSString *)ImageName
{
    _ImageView.image = [UIImage imageNamed:ImageName];
}
- (void)setShowString:(NSString *)ShowString
{
    _showLabel.text = ShowString;

}
- (void)setDetailSrtring:(NSString *)DetailSrtring
{
    _deatilLabel.text = DetailSrtring;
}
- (void)tapclick
{
    if (self.ImageClick) {
        self.ImageClick();
    }
}

@end
