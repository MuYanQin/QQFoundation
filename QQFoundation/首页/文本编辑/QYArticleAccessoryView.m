//
//  QYArticleAccessoryView.m
//  QQFoundation
//
//  Created by leaduMac on 2020/8/7.
//  Copyright © 2020 Yuan er. All rights reserved.
//

#import "QYArticleAccessoryView.h"

@implementation QYArticleAccessoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = getColorWithHex(@"#F9F8F8");
        [self initView];
    }
    return self;
}
- (void)initView{
    NSArray *array = @[@"article_image",@"article_image",@"article_location",@"article_at"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QQButton *button = [QQButton buttonWithType:(UIButtonTypeCustom)];
        button.QimageSize(CGSizeMake(21, 21)).Qimage([UIImage imageNamed:obj])
        .QInfo(@(idx)).Qtarget(self, @selector(buttonClick:));
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.equalTo(self).offset(40*idx + 5*(idx + 1));
            make.centerY.equalTo(self);
        }];
    }];
    
    QQButton *button = [QQButton buttonWithType:(UIButtonTypeCustom)];
    button.Qtext(@"# 添加标签").QInfo(@(4)).Qtarget(self, @selector(buttonClick:))
    .Qfont(14).QtextClolor(getColorWithHex(@"#999999"));
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 40));
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    
}
- (void)buttonClick:(QQButton *)btn
{
    if (self.clickIndex) {
        self.clickIndex([btn.info integerValue]);
    }
}
@end
