//
//  MCContentView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/10/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCContentView.h"
#import "MCContentHeadView.h"
#import "MCContentTableView.h"
@interface MCContentView ()
@property (nonatomic , strong) UIScrollView * contentView;
@property (nonatomic , strong) MCContentHeadView * contentHeadView;
@property (nonatomic , strong) MCContentTableView * contentTableView;
@end

@implementation MCContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews
{
    
}
- (MCContentHeadView *)contentHeadView
{
    if (!_contentHeadView) {
        _contentHeadView = [[MCContentHeadView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        _contentHeadView.backgroundColor = [UIColor redColor];
        
    }
    return _contentHeadView;
}
- (void)setHeadViewHeight:(CGFloat)headViewHeight
{
    _headViewHeight = headViewHeight;
    
    CGRect rect = self.contentHeadView.frame;
    rect.size.height = headViewHeight;
    self.contentHeadView.frame = rect;
}
@end
