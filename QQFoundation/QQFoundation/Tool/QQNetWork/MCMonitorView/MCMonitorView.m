//
//  MCMonitorView.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/10/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCMonitorView.h"
#import "MCWebViewViewController.h"
#import "UIView+SuperViewController.h"
#import "QQTool.h"
@interface MCMonitorView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * dataArray;
@end
@implementation MCMonitorView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [NSMutableArray array];
        [self addSubview:self.tableView];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    NSDictionary *dic  = self.dataArray[indexPath.row];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *temp;
        if ([obj isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)obj;
            temp = [NSString stringWithFormat:@"%@--%@",@"链接失败",@(error.code)];
        }else{
            temp = @"链接成功";
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",key,temp];
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic  = self.dataArray[indexPath.row];
    MCWebViewViewController *webView = [MCWebViewViewController new];
    UINavigationController *nav=  [[UINavigationController alloc]initWithRootViewController:webView];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSError class]]) {
            webView.contentHtml = [QQTool dictionaryToJson:obj];
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }];
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = (int)self.frame.size.height/2;
    }
    return _tableView;
}
- (void)setDataDic:(NSDictionary *)dataDic
{
    if (self.dataArray.count > 2) {
        [self.dataArray removeObjectAtIndex:0];
    }
    [self.dataArray addObject:dataDic];
    [self.tableView reloadData];
}
@end
