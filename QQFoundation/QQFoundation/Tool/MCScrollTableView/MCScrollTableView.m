//
//  MCScrollTableView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/28.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCScrollTableView.h"
#import "MCPageView.h"
#import "fourViewController.h"
@interface MCScrollTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) MCPageView * pageView;
@end
@implementation MCScrollTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initMCScrollTab];
    }
    return self;
}
- (void)initMCScrollTab
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tableView.allowsSelection = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableView"];
    }
    if (indexPath.row == 0) {
        [cell addSubview:self.headerView];
    }else{
        [cell addSubview:self.pageView];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return self.headerView.frame.size.height;
    }else{
        return self.frame.size.height;
    }
}
- (void)setHeaderView:(UIView *)headerView
{
    _headerView = headerView;
    [self.tableView reloadData];
}
- (MCPageView *)pageView
{
    if (!_pageView) {
        _pageView = [[MCPageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height) titles:@[@"我的",@"信息"] controllers:@[[fourViewController new],[fourViewController new]]];
    }
    return _pageView;
}
@end
