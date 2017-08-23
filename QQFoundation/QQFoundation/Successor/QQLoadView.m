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
@property (strong, nonatomic)UIImageView *BGImageView ;///<中间的图片
@property (nonatomic,strong) UILabel *alertLabel;///<中间大一点的提示文字
@property (nonatomic,strong) UILabel *deatilLabel;///<下面小一点的字体
@end

@implementation QQLoadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame]) {
        _LoadViewType = QQLoadViewNone;
//        self.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        [self initParameters];
    }
    return self;
}
- (void)initParameters
{
    _BGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2 - 50,100, 100, 100)];
    _BGImageView.image = [UIImage imageNamed:@"icon_server_default_icon"];
    _BGImageView.userInteractionEnabled = YES;
    [self addSubview:_BGImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick)];
    [_BGImageView addGestureRecognizer:tap];
    
    _alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2 - 100, _BGImageView.bottom + 10, 200, 20)];
    _alertLabel.font = [UIFont systemFontOfSize:14];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_alertLabel];

    _deatilLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2 - 50, _alertLabel.bottom + 10, 100, 20)];
    _deatilLabel.font = [UIFont systemFontOfSize:12];
    _deatilLabel.textAlignment = NSTextAlignmentCenter;
    _deatilLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:_deatilLabel];

}
- (void)setLoadViewType:(QQLoadViewType)LoadViewType
{
    _LoadViewType = LoadViewType;
    switch (LoadViewType) {
        case QQLoadViewNone:
        {
            self.hidden = YES;
            [self.superview sendSubviewToBack:self];
            break;
            
        }
        case QQLoadViewEmpty:
        {
            _BGImageView.userInteractionEnabled = NO;
//            _BGImageView.image = [UIImage imageNamed:@"icon_em_al"];
//            _deatilLabel.text = @"下拉刷新";
//            _alertLabel.text = @"暂无数据";
            self.hidden = NO;
            [self.superview bringSubviewToFront:self];
            break;
        }
        case QQLoadViewErrornetwork:
        {
            _BGImageView.image = [UIImage imageNamed:@"multi_network_error_icon@2x"];
            _deatilLabel.text = @"点击或者下拉刷新";
            _alertLabel.text = @"网络连接错误，请重试！";
            self.hidden = NO;
            [self.superview bringSubviewToFront:self];
            break;
        }
        case QQLoadViewErrorServer:
        {
            _BGImageView.image = [UIImage imageNamed:@"multi_network_error_icon@2x"];
            _alertLabel.text = @"服务断开，小盟们正在抢修！";
            self.hidden = NO;
            [self.superview bringSubviewToFront:self];
            break;
        }
        default:
            break;
    }
}
- (void)setImageSrtring:(NSString *)ImageSrtring
{
    _BGImageView.image = [UIImage imageNamed:ImageSrtring];
}
- (void)setAlertSrtring:(NSString *)alertSrtring
{
    _alertLabel.text = alertSrtring;
}
- (void)setDetailSrtring:(NSString *)DetailSrtring
{
    _deatilLabel.text = DetailSrtring;
}
- (void)tapclick
{
    if (_clickblock) {
        _clickblock();
    }
}

@end
